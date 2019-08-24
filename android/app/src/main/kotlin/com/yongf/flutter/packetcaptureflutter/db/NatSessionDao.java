package com.yongf.flutter.packetcaptureflutter.db;

import android.arch.persistence.room.Dao;
import android.arch.persistence.room.Delete;
import android.arch.persistence.room.Insert;
import android.arch.persistence.room.Query;
import android.arch.persistence.room.Update;

import java.util.List;

/**
 * @author wangyong.1996@bytedance.com
 * @since 2019-04-21.
 */
@Dao
public interface NatSessionDao {

    @Query("SELECT * FROM TB_NAT_SESSION")
    List<NatSessionEntity> getAll();

    @Query("SELECT * FROM tb_nat_session where id in (:ids)")
    List<NatSessionEntity> getAllByIds(long[] ids);

    @Insert
    void insert(NatSessionEntity... entities);

    @Delete
    void delete(NatSessionEntity entity);

    @Update
    void update(NatSessionEntity entity);
}
