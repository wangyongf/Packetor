package com.yongf.flutter.packetcaptureflutter.util

import android.content.Context
import com.minhui.vpn.utils.VpnServiceHelper

/**
 * @author scottwang1996@qq.com
 * @since 2019/1/3.
 */
object PcfHelper {
    fun startVPN(context: Context) {
        VpnServiceHelper.changeVpnRunningStatus(context, true)
    }

    fun stopVPN(context: Context) {
        VpnServiceHelper.changeVpnRunningStatus(context, false)
    }
}