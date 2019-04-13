package com.yongf.flutter.packetcaptureflutter.extension

import com.minhui.vpn.utils.SaveDataFileParser
import com.yongf.flutter.packetcaptureflutter.model.NatSessionRequestModel

/**
 * @author wangyong.1996@bytedance.com
 * @since 2019/4/11.
 */
fun SaveDataFileParser.ShowData.toProtoModel(): NatSessionRequestModel.NatSessionRequest {
    val data = this
    return NatSessionRequestModel.NatSessionRequest.newBuilder()
            .setIsRequest(data.isRequest)
            .setHeadStr(data.headStr ?: "")
            .setBodyStr(data.bodyStr ?: "")
            .setBodyImage(data.bodyImage.toProtoByteString())
            .build()
}
