package com.yongf.flutter.packetcaptureflutter.extension

import android.graphics.Bitmap
import android.util.Log
import com.google.protobuf.ByteString
import java.io.ByteArrayOutputStream

/**
 * @author wangyong.1996@bytedance.com
 * @since 2019/4/11.
 */
fun Bitmap?.toProtoByteString(): ByteString {
    val bitmap = this ?: return ByteString.EMPTY
    Log.i("tag", "bitmap != null")
    var bos = ByteArrayOutputStream()
    bitmap?.compress(Bitmap.CompressFormat.PNG, 100, bos)
    val bytes = bos.toByteArray()
    bos.close()
    return ByteString.copyFrom(bytes)
//    return ByteString.EMPTY
}
