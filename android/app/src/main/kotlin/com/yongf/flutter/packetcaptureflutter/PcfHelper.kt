package com.yongf.flutter.packetcaptureflutter

import android.content.Context
import com.minhui.vpn.utils.VpnServiceHelper

/**
 * @author scottwang1996@qq.com
 * @since 2019/1/3.
 */
class PcfHelper {

    companion object {
        fun startVPN(context: Context) {
            VpnServiceHelper.changeVpnRunningStatus(context, true)
        }

        fun stopVPN(context: Context) {
            VpnServiceHelper.changeVpnRunningStatus(context, false)
        }
    }
}