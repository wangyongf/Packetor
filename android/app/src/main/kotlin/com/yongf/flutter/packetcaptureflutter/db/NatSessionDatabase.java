package com.yongf.flutter.packetcaptureflutter.db;

import android.arch.persistence.room.Database;
import android.arch.persistence.room.RoomDatabase;

/**
 * @author wangyong.1996@bytedance.com
 * @since 2019-04-21.
 */
@Database(entities = {NatSessionEntity.class}, version = 1)
public abstract class NatSessionDatabase extends RoomDatabase {

    public abstract NatSessionDao getNatSessionDao();
}
