package com.yongf.flutter.packetcaptureflutter

import android.app.Application

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