package com.yongf.flutter.packetcaptureflutter.extension

import android.app.Activity
import android.graphics.Bitmap
import com.google.protobuf.ByteString
import com.minhui.vpn.nat.NatSession
import com.minhui.vpn.processparse.AppInfo
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
            .setRemoteHost(natSession.getRemoteHost())
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
                    .setAppName(getAppName(natSession.getAppInfo()))
                    .setPackageName(getAppPackageName(activity, natSession.getAppInfo()))
                    .setIcon(getAppIcon(activity))
                    .build())
            .build()
}

private fun getAppName(appInfo: AppInfo?): String {
    if (appInfo == null) {
        return "Unknown App"
    }
    return "抖音短视频"
}

private fun getAppPackageName(activity: Activity, appInfo: AppInfo?): String {
    if (appInfo == null) {
        return "Unknown Package"
    }
    return activity.packageName
}

private fun getAppIcon(activity: Activity): com.google.protobuf.ByteString {
    val icon = activity.packageManager.getPackageInfo(activity.packageName, 0)
            .applicationInfo.loadIcon(activity.packageManager)
    val bitmap = icon.toBitmap()
    var bos = ByteArrayOutputStream()
    bitmap?.compress(Bitmap.CompressFormat.PNG, 100, bos)
    val bytes = bos.toByteArray()
    bos.close()

    return ByteString.copyFrom(bytes)
}
