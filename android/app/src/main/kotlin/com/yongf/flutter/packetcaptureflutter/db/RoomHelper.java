package com.yongf.flutter.packetcaptureflutter.db;

import android.arch.persistence.db.SupportSQLiteDatabase;
import android.arch.persistence.room.Room;
import android.arch.persistence.room.RoomDatabase;
import android.content.Context;
import android.support.annotation.NonNull;
import android.util.Log;

/**
 * @author wangyong.1996@bytedance.com
 * @since 2019-04-21.
 */
public class RoomHelper {

    private static final String TAG = RoomHelper.class.getSimpleName();

    private static NatSessionDatabase INSTANCE;

    public static void setupDatabase(Context context) {
        INSTANCE = Room.databaseBuilder(context, NatSessionDatabase.class, "database_nat_session")
                .addCallback(new RoomDatabase.Callback() {
                    @Override
                    public void onCreate(@NonNull SupportSQLiteDatabase db) {
                        super.onCreate(db);
                        Log.i(TAG, "onCreate Room " + db.getPath());
                    }

                    @Override
                    public void onOpen(@NonNull SupportSQLiteDatabase db) {
                        super.onOpen(db);
                        Log.i(TAG, "onOpen Room " + db.getPath());
                    }
                })
                .allowMainThreadQueries()
                .addMigrations()
                .fallbackToDestructiveMigration()
                .build();
    }

    public static NatSessionDatabase getNatSessionDatabase() {
        return INSTANCE;
    }
}
