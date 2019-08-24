package com.yongf.flutter.packetcaptureflutter.app

import android.Manifest
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.*
import android.support.v4.app.ActivityCompat
import android.util.Log
import android.widget.Toast
import com.minhui.vpn.ProxyConfig
import com.minhui.vpn.VPNConstants
import com.minhui.vpn.VPNConstants.DEFAULT_PACKAGE_ID
import com.minhui.vpn.nat.NatSession
import com.minhui.vpn.utils.SaveDataFileParser
import com.minhui.vpn.utils.ThreadProxy
import com.minhui.vpn.utils.VpnServiceHelper
import com.yongf.flutter.packetcaptureflutter.db.RoomHelper
import com.yongf.flutter.packetcaptureflutter.extension.toNatSessionEntity
import com.yongf.flutter.packetcaptureflutter.extension.toProtoModel
import com.yongf.flutter.packetcaptureflutter.model.NatSessionModel
import com.yongf.flutter.packetcaptureflutter.model.NatSessionRequestModel
import com.yongf.flutter.packetcaptureflutter.util.PcfHelper
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File
import java.nio.ByteBuffer
import java.util.*
import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService
import java.util.concurrent.TimeUnit

class MainActivity : FlutterActivity() {
    companion object {
        const val CHANNEL = "pcf.flutter.yongf.com/battery"
        const val PCF_CHANNEL = "flutter.yongf.com/pcf"
        const val PCF_TRANSFER_SESSION = "flutter.yongf.com/pcf/session"

        const val ARG_SESSION_DIR = "session_dir"
        const val ARG_SESSION = "session"
        const val ARG_DIR = "dir"
    }

    private lateinit var channel: MethodChannel
    private lateinit var pcf: MethodChannel
    private lateinit var pcfSession: MethodChannel

    private var timer: ScheduledExecutorService? = null
    private lateinit var handler: Handler
    private var allNetConnection: MutableList<NatSession> = mutableListOf()
    private var session: NatSessionModel.NatSession? = null

    private var listener: ProxyConfig.VpnStatusListener = object : ProxyConfig.VpnStatusListener {

        override fun onVpnStart(context: Context) {
            startTimer()
        }

        override fun onVpnEnd(context: Context) {
            stopTimer()
        }
    }

    private fun getTag(): String {
        return MainActivity.javaClass.simpleName
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        SdkInitHelper.init(application)

        GeneratedPluginRegistrant.registerWith(this)

        handler = Handler()
        ProxyConfig.Instance.registerVpnStatusListener(listener)
        if (VpnServiceHelper.vpnRunningStatus()) {
            startTimer()
        }

        channel = MethodChannel(flutterView, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when {
                call.method == "getBatteryLevel" -> {
                    handleGetBatteryLevel(result)
//                    invokeDart()
                }
                call.method == "startVPN" -> startVPN(result)
                call.method == "stopVPN" -> stopVPN(result)
                call.method == "requestSessions" -> requestSessions(result)
                else -> result.notImplemented()
            }
        }

        pcf = MethodChannel(flutterView, PCF_CHANNEL)
        pcf.setMethodCallHandler { call, result ->
            when (call.method) {
                "transfer" -> transfer()
                else -> result.notImplemented()
            }
        }

        pcfSession = MethodChannel(flutterView, PCF_TRANSFER_SESSION)
        pcfSession.setMethodCallHandler { call, result ->
            when (call.method) {
                "transferSessionByDir" -> transferSessionByDir(call)
                "saveSession" -> saveSession(call, result)
                else -> result.notImplemented()
            }
        }
        flutterView.setMessageHandler(PCF_TRANSFER_SESSION) { message, reply ->
            //            message.order(ByteOrder.nativeOrder())
            // TODO: 这种方式存在问题，暂时先这么做
            session = NatSessionModel.NatSession.parseFrom(message.array())
            reply.reply(null)
        }

        getData()
        checkPermission()
    }

    private fun saveSession(call: MethodCall, result: MethodChannel.Result) {
        var dir: String? = call.argument(ARG_DIR)
        if (dir.isNullOrEmpty() || session == null) {
            result.success(false)
            return
        }
        performSaveSession(session!!, dir)
        result.success(true)
    }

    private fun performSaveSession(session: NatSessionModel.NatSession, dir: String) {
        var entity = session.toNatSessionEntity(this, dir)
        // TODO: 直接 insert 的处理有问题！！！
        RoomHelper.getNatSessionDatabase().natSessionDao.insert(entity)
    }

    private fun transferSessionByDir(call: MethodCall) {
        var sessionDir: String? = call.argument(ARG_SESSION_DIR)
        if (sessionDir.isNullOrEmpty()) {
            return
        }
        sessionDir = Environment.getExternalStorageDirectory().absolutePath + sessionDir
        Log.i(getTag(), sessionDir)
        ThreadProxy.getInstance().execute {
            var file = File(sessionDir)
            val files = file.listFiles()
            if (files == null || files.isEmpty()) {
                Log.i(getTag(), "empty")
                return@execute
            }
            Log.i(getTag(), "file size: " + files.size)
            val filesList = mutableListOf<File>()
            for (childFile in files) {
                filesList.add(childFile)
            }
            filesList.sortWith(Comparator { o1, o2 -> (o1.lastModified() - o2.lastModified()).toInt() })
            val showDataList = mutableListOf<SaveDataFileParser.ShowData>()
            for (childFile in filesList) {
                val showData = SaveDataFileParser.parseSaveFile(childFile)
                if (showData != null) {
                    showDataList.add(showData)
                }
            }
            val requestsBuilder = NatSessionRequestModel.NatSessionRequests.newBuilder()
            for (showData in showDataList) {
                val request = showData.toProtoModel()
                requestsBuilder.addRequest(request)
            }
            val requests = requestsBuilder.build()
            val bytes = requests.toByteArray()
            val buffer = ByteBuffer.allocateDirect(bytes.size)
            buffer.put(bytes)
            flutterView.send(PCF_TRANSFER_SESSION, buffer)
            buffer.clear()
        }
    }

    private fun checkPermission() {
        ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE), 0)
    }

    private fun requestSessions(result: MethodChannel.Result) {
//        result.success(allNetConnection)
        result.success("All Sessions from Android")
    }

    private fun getData() {
        ThreadProxy.getInstance().execute {
            var sessions: MutableList<NatSession> = mutableListOf()
            sessions.addAll(VpnServiceHelper.getAllSession() ?: return@execute)
            if (sessions.isEmpty()) {
                handler.post { refreshData(sessions) }
                return@execute
            }
            val iterator = sessions.iterator()
            val packageName = packageName

            val sp = getSharedPreferences(VPNConstants.VPN_SP_NAME, Context.MODE_PRIVATE)
            val isShowUDP = sp.getBoolean(VPNConstants.IS_UDP_SHOW, false)
            val selectPackage = sp.getString(DEFAULT_PACKAGE_ID, null)

            while (iterator.hasNext()) {
                val next = iterator.next()
                if (next.bytesSent == 0 && next.receivedByteNum == 0L) {
                    iterator.remove()
                    continue
                }
                if (NatSession.UDP == next.type && !isShowUDP) {
                    iterator.remove()
                    continue
                }
                val appInfo = next.appInfo

                if (appInfo != null) {
                    val appPackageName = appInfo.pkgs.getAt(0)
                    if (packageName == appPackageName) {
                        iterator.remove()
                        continue
                    }
                    if (selectPackage != null && selectPackage != appPackageName) {
                        iterator.remove()
                    }
                }
            }
            if (handler == null) {
                return@execute
            }
            handler.post { refreshData(sessions) }
        }
    }

    override fun onStop() {
        super.onStop()

        ProxyConfig.Instance.unregisterVpnStatusListener(listener)
        stopTimer()
    }

    private fun startVPN(result: MethodChannel.Result) {
        PcfHelper.startVPN(this)
        startTimer()
        result.success(true)
    }

    private fun stopVPN(result: MethodChannel.Result) {
        PcfHelper.stopVPN(this)
        stopTimer()
        result.success(true)
    }

    private fun transfer() {
        val raw = allNetConnection.filter { natSession: NatSession ->
            var result = natSession.bytesSent > 0 && natSession.receivedByteNum > 0
            result = result && natSession.appInfo?.pkgs?.getAt(0) != null
            result
        }
        val sessionsBuilder = NatSessionModel.NatSessions.newBuilder()
        for (natSession in raw) {
            val session = natSession.toProtoModel(this)
            sessionsBuilder.addSession(session)
        }
        val sessions = sessionsBuilder.build()
        val bytes = sessions.toByteArray()
        val buffer = ByteBuffer.allocateDirect(bytes.size)
        buffer.put(bytes)
        flutterView.send(PCF_CHANNEL, buffer)
        buffer.clear()
    }

    private fun handleGetBatteryLevel(result: MethodChannel.Result) {
        val batteryLevel = getBatteryLevel()
        if (batteryLevel != -1) {
            result.success(batteryLevel)
        } else {
            result.error("UNAVAILABLE", "Battery level not available.", null)
        }
    }

    private fun refreshData(sessions: List<NatSession>) {
        if (sessions == null) {
            return
        }
        allNetConnection.clear()
        allNetConnection.addAll(sessions)
    }

    private fun startTimer() {
        timer = Executors.newSingleThreadScheduledExecutor()

        timer?.scheduleAtFixedRate(object : TimerTask() {
            override fun run() {
                getData()
            }
        }, 1000, 1000, TimeUnit.MILLISECONDS)
    }

    private fun stopTimer() {
        if (timer == null) {
            return
        }
        timer?.shutdownNow()
        timer = null
    }

    private fun invokeDart() {
        channel.invokeMethod("refresh", "Hello from Android!", object : MethodChannel.Result {
            override fun notImplemented() {
                Toast.makeText(this@MainActivity, "notImplemented", Toast.LENGTH_LONG).show()
            }

            override fun error(p0: String?, p1: String?, p2: Any?) {
                Toast.makeText(this@MainActivity, "error", Toast.LENGTH_LONG).show()
            }

            override fun success(p0: Any?) {
                Toast.makeText(this@MainActivity, p0 as String?, Toast.LENGTH_LONG).show()
            }
        })
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        batteryLevel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
}
