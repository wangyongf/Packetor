package com.yongf.flutter.packetcaptureflutter.extension

import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.PixelFormat
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.graphics.drawable.NinePatchDrawable


/**
 * @author wangyong.1996@bytedance.com
 * @since 2019/3/30.
 */

/**
 * Drawable 转 Bitmap
 */
fun Drawable.toBitmap(): Bitmap? {
    when (this) {
        is BitmapDrawable -> return bitmap
        is NinePatchDrawable -> {
            val bitmap = Bitmap
                    .createBitmap(
                            getIntrinsicWidth(),
                            getIntrinsicHeight(),
                            if (getOpacity() !== PixelFormat.OPAQUE)
                                Bitmap.Config.ARGB_8888
                            else
                                Bitmap.Config.RGB_565)
            val canvas = Canvas(bitmap)
            setBounds(0, 0, getIntrinsicWidth(), getIntrinsicHeight())
            draw(canvas)
            return bitmap
        }
        else -> return null
    }
}