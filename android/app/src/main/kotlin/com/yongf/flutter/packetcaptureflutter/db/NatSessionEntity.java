package com.yongf.flutter.packetcaptureflutter.db;

import android.arch.persistence.room.ColumnInfo;
import android.arch.persistence.room.Entity;
import android.arch.persistence.room.PrimaryKey;

/**
 * @author wangyong.1996@bytedance.com
 * @since 2019-04-21.
 */
@Entity(tableName = "tb_nat_session")
public class NatSessionEntity {

    @PrimaryKey(autoGenerate = true)
    private long id;
    private String type;
    private String ipAndPort;
    private int remoteIP;
    private int remotePort;
    private String remoteHost;
    private int localIP;
    private int localPort;
    private int bytesSent;
    private int packetSent;
    private long receivedByteNum;
    private long receivedPacketNum;
    private long lastRefreshTime;
    private boolean isHttpsSession;
    private String requestUrl;
    private String path;
    private String method;
    private long connectionStartTime;
    private long vpnStartTime;
    private boolean isHttp;
    private String uniqueName;
    private String appName;
    private String packageName;
    private String sessionDataLocalAbsPath;

    public static final class NatSessionEntityBuilder {
        private String type;
        private String ipAndPort;
        private int remoteIP;
        private int remotePort;
        private String remoteHost;
        private int localIP;
        private int localPort;
        private int bytesSent;
        private int packetSent;
        private long receivedByteNum;
        private long receivedPacketNum;
        private long lastRefreshTime;
        private boolean isHttpsSession;
        private String requestUrl;
        private String path;
        private String method;
        private long connectionStartTime;
        private long vpnStartTime;
        private boolean isHttp;
        private String uniqueName;
        private String appName;
        private String packageName;
        private String sessionDataLocalAbsPath;

        private NatSessionEntityBuilder() {
        }

        public static NatSessionEntityBuilder aNatSessionEntity() {
            return new NatSessionEntityBuilder();
        }

        public NatSessionEntityBuilder withType(String type) {
            this.type = type;
            return this;
        }

        public NatSessionEntityBuilder withIpAndPort(String ipAndPort) {
            this.ipAndPort = ipAndPort;
            return this;
        }

        public NatSessionEntityBuilder withRemoteIP(int remoteIP) {
            this.remoteIP = remoteIP;
            return this;
        }

        public NatSessionEntityBuilder withRemotePort(int remotePort) {
            this.remotePort = remotePort;
            return this;
        }

        public NatSessionEntityBuilder withRemoteHost(String remoteHost) {
            this.remoteHost = remoteHost;
            return this;
        }

        public NatSessionEntityBuilder withLocalIP(int localIP) {
            this.localIP = localIP;
            return this;
        }

        public NatSessionEntityBuilder withLocalPort(int localPort) {
            this.localPort = localPort;
            return this;
        }

        public NatSessionEntityBuilder withBytesSent(int bytesSent) {
            this.bytesSent = bytesSent;
            return this;
        }

        public NatSessionEntityBuilder withPacketSent(int packetSent) {
            this.packetSent = packetSent;
            return this;
        }

        public NatSessionEntityBuilder withReceivedByteNum(long receivedByteNum) {
            this.receivedByteNum = receivedByteNum;
            return this;
        }

        public NatSessionEntityBuilder withReceivedPacketNum(long receivedPacketNum) {
            this.receivedPacketNum = receivedPacketNum;
            return this;
        }

        public NatSessionEntityBuilder withLastRefreshTime(long lastRefreshTime) {
            this.lastRefreshTime = lastRefreshTime;
            return this;
        }

        public NatSessionEntityBuilder withIsHttpsSession(boolean isHttpsSession) {
            this.isHttpsSession = isHttpsSession;
            return this;
        }

        public NatSessionEntityBuilder withRequestUrl(String requestUrl) {
            this.requestUrl = requestUrl;
            return this;
        }

        public NatSessionEntityBuilder withPath(String path) {
            this.path = path;
            return this;
        }

        public NatSessionEntityBuilder withMethod(String method) {
            this.method = method;
            return this;
        }

        public NatSessionEntityBuilder withConnectionStartTime(long connectionStartTime) {
            this.connectionStartTime = connectionStartTime;
            return this;
        }

        public NatSessionEntityBuilder withVpnStartTime(long vpnStartTime) {
            this.vpnStartTime = vpnStartTime;
            return this;
        }

        public NatSessionEntityBuilder withIsHttp(boolean isHttp) {
            this.isHttp = isHttp;
            return this;
        }

        public NatSessionEntityBuilder withUniqueName(String uniqueName) {
            this.uniqueName = uniqueName;
            return this;
        }

        public NatSessionEntityBuilder withAppName(String appName) {
            this.appName = appName;
            return this;
        }

        public NatSessionEntityBuilder withPackageName(String packageName) {
            this.packageName = packageName;
            return this;
        }

        public NatSessionEntityBuilder withSessionDataLocalAbsPath(String sessionDataLocalAbsPath) {
            this.sessionDataLocalAbsPath = sessionDataLocalAbsPath;
            return this;
        }

        public NatSessionEntity build() {
            NatSessionEntity natSessionEntity = new NatSessionEntity();
            natSessionEntity.lastRefreshTime = this.lastRefreshTime;
            natSessionEntity.remoteHost = this.remoteHost;
            natSessionEntity.bytesSent = this.bytesSent;
            natSessionEntity.vpnStartTime = this.vpnStartTime;
            natSessionEntity.receivedPacketNum = this.receivedPacketNum;
            natSessionEntity.isHttp = this.isHttp;
            natSessionEntity.uniqueName = this.uniqueName;
            natSessionEntity.sessionDataLocalAbsPath = this.sessionDataLocalAbsPath;
            natSessionEntity.isHttpsSession = this.isHttpsSession;
            natSessionEntity.ipAndPort = this.ipAndPort;
            natSessionEntity.receivedByteNum = this.receivedByteNum;
            natSessionEntity.connectionStartTime = this.connectionStartTime;
            natSessionEntity.appName = this.appName;
            natSessionEntity.path = this.path;
            natSessionEntity.packageName = this.packageName;
            natSessionEntity.type = this.type;
            natSessionEntity.packetSent = this.packetSent;
            natSessionEntity.method = this.method;
            natSessionEntity.localIP = this.localIP;
            natSessionEntity.localPort = this.localPort;
            natSessionEntity.remotePort = this.remotePort;
            natSessionEntity.remoteIP = this.remoteIP;
            natSessionEntity.requestUrl = this.requestUrl;
            return natSessionEntity;
        }
    }
}
