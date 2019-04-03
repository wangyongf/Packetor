package com.yongf.flutter.packetcaptureflutter.extension

import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import com.google.protobuf.ByteString
import com.minhui.vpn.nat.NatSession
import com.minhui.vpn.processparse.AppInfo
import com.yongf.flutter.packetcaptureflutter.common.Packages
import com.yongf.flutter.packetcaptureflutter.model.NatSessionModel
import java.io.ByteArrayOutputStream

/**
 * @author wangyong.1996@bytedance.com
 * @since 2019/3/30.
 */
fun NatSession.transform(activity: Activity): NatSessionModel.NatSession {
    val natSession = this

    return NatSessionModel.NatSession.newBuilder()
            .setType(natSession.getType())
            .setIpAndPort(natSession.getIpAndPort())
            .setRemoteIP(natSession.getRemoteIP())
            .setRemoteHost(natSession.getRemoteHost() ?: "")
            .setLocalIP(natSession.getLocalIP())
            .setLocalPort(natSession.getLocalPort().toInt())
            .setBytesSent(natSession.getBytesSent())
            .setPacketSent(natSession.getPacketSent())
            .setReceivedByteNum(natSession.getReceivedByteNum())
            .setReceivedPacketNum(natSession.getReceivedPacketNum())
            .setLastRefreshTime(natSession.getLastRefreshTime())
            .setIsHttpsSession(natSession.isHttpsSession())
            .setRequestUrl(natSession.getRequestUrl() ?: "")
            .setPath(natSession.getPath() ?: "")
            .setMethod(natSession.getMethod() ?: "")
            .setConnectionStartTime(natSession.getConnectionStartTime())
            .setVpnStartTime(natSession.getVpnStartTime())
            .setIsHttp(natSession.isHttp())
            .setAppInfo(NatSessionModel.AppInfo.newBuilder()
                    .setAppName(getAppName(activity, natSession.getAppInfo()))
                    .setPackageName(getAppPackageName(activity, natSession.getAppInfo()))
                    .setIcon(getAppIcon(activity, natSession.getAppInfo()))
                    .build())
            .build()
}

private fun getAppName(context: Context, appInfo: AppInfo?): String {
    if (appInfo == null) {
        return "Unknown App"
    }
    return context.packageManager.getApplicationInfo(appInfo.pkgs.getAt(0), 0)
            .loadLabel(context.packageManager).toString()
}

private fun getAppPackageName(activity: Activity, appInfo: AppInfo?): String {
    if (appInfo == null) {
        return activity.packageName
    }
    return appInfo.pkgs.getAt(0)
}

private fun getAppIcon(activity: Activity, appInfo: AppInfo?): com.google.protobuf.ByteString {
//    var packageName = randomPkgName(activity)
    var packageName = getAppPackageName(activity, appInfo)
    val icon = activity.packageManager.getPackageInfo(packageName, 0)
            .applicationInfo.loadIcon(activity.packageManager)
    val bitmap = icon.toBitmap()
    var bos = ByteArrayOutputStream()
    bitmap?.compress(Bitmap.CompressFormat.PNG, 100, bos)
    val bytes = bos.toByteArray()
    bos.close()

    return ByteString.copyFrom(bytes)
}

private fun randomPkgName(activity: Activity): String? {
    val nextInt = (0..6).random()
    return when (nextInt) {
        0 -> activity.packageName
        1 -> Packages.WECHAT
        2 -> Packages.QQ
        3 -> Packages.WEREAD
        4 -> Packages.QQ_MUSIC
        5 -> Packages.CLOUD_MUSIC
        else -> Packages.MOBIKE
    }
}
