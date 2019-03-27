package com.yongf.flutter.packetcaptureflutter

import android.Manifest
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.support.v4.app.ActivityCompat
import android.widget.Toast
import com.minhui.vpn.ProxyConfig
import com.minhui.vpn.VPNConstants
import com.minhui.vpn.VPNConstants.DEFAULT_PACKAGE_ID
import com.minhui.vpn.nat.NatSession
import com.minhui.vpn.utils.ThreadProxy
import com.minhui.vpn.utils.VpnServiceHelper
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.util.*
import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService
import java.util.concurrent.TimeUnit


class MainActivity : FlutterActivity() {
    private val CHANNEL = "pcf.flutter.yongf.com/battery";
    private lateinit var channel: MethodChannel

    private var timer: ScheduledExecutorService? = null
    private lateinit var handler: Handler
    private var allNetConnection: MutableList<NatSession> = mutableListOf()
    private var listener: ProxyConfig.VpnStatusListener = object : ProxyConfig.VpnStatusListener {

        override fun onVpnStart(context: Context) {
            startTimer()
        }

        override fun onVpnEnd(context: Context) {
            stopTimer()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        CrashHandler.getInstance().init(this)

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
                call.method == "getAllSessions" -> getAllSessions(result)
                else -> result.notImplemented()
            }
        }

        getData()
        checkP()
    }

    private fun checkP() {
        ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE), 0)
    }

    private fun getAllSessions(result: MethodChannel.Result) {
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

    private fun handleGetBatteryLevel(result: MethodChannel.Result) {
        val batteryLevel = getBatteryLevel()

        if (batteryLevel != -1) {
            result.success(batteryLevel)
        } else {
            result.error("UNAVAILABLE", "Battery level not available.", null)
        }
    }

    private fun refreshData(sessions: List<NatSession>) {
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
            return;
        }
        timer?.shutdownNow();
        timer = null;
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
        val batteryLevel: Int;
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
