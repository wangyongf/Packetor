package com.yongf.flutter.packetcaptureflutter.util;

import java.io.File;

/**
 * @author scottwang1996@qq.com
 * @since 2019/1/4.
 */
public class FileHelper {

    public static void mkdirs(String path) {
        File file = new File(path);
        File parent = file.getParentFile();
        if (!parent.exists()) {
            mkdirs(parent.getAbsolutePath());
        }
        file.mkdir();
    }
}
