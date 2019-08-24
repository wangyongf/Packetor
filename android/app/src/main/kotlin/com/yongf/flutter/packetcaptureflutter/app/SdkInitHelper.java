package com.yongf.flutter.packetcaptureflutter.app;

import android.app.Application;
import android.content.Context;

import com.yongf.flutter.packetcaptureflutter.db.RoomHelper;
import com.yongf.flutter.packetcaptureflutter.util.CrashHandler;

/**
 * @author wangyong.1996@bytedance.com
 * @since 2019-04-21.
 */
public final class SdkInitHelper {

    private static final String TAG = SdkInitHelper.class.getSimpleName();

    public static void init(Application app) {
        initCrashHandler(app);
        initRoom(app);
    }

    private static void initCrashHandler(Context context) {
        CrashHandler.getInstance().init(context);
    }

    private static void initRoom(Context context) {
        RoomHelper.setupDatabase(context);
    }
}
