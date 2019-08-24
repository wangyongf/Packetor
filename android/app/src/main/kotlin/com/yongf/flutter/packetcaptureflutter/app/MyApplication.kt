package com.yongf.flutter.packetcaptureflutter.app

import android.app.Application
import com.yongf.flutter.packetcaptureflutter.util.CrashHandler

/**
 * @author scottwang1996@qq.com
 * @since 2019/1/4.
 */
class MyApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        CrashHandler.getInstance().init(this)
    }
}