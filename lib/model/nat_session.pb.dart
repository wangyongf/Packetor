///
//  Generated code. Do not modify.
//  source: android/app/src/main/proto/nat_session.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, Map, override;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

class NatSessions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('NatSessions', package: const $pb.PackageName('com.yongf.flutter.packetcaptureflutter.model'))
    ..pc<NatSession>(1, 'session', $pb.PbFieldType.PM,NatSession.create)
    ..hasRequiredFields = false
  ;

  NatSessions() : super();
  NatSessions.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NatSessions.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NatSessions clone() => new NatSessions()..mergeFromMessage(this);
  NatSessions copyWith(void Function(NatSessions) updates) => super.copyWith((message) => updates(message as NatSessions));
  $pb.BuilderInfo get info_ => _i;
  static NatSessions create() => new NatSessions();
  NatSessions createEmptyInstance() => create();
  static $pb.PbList<NatSessions> createRepeated() => new $pb.PbList<NatSessions>();
  static NatSessions getDefault() => _defaultInstance ??= create()..freeze();
  static NatSessions _defaultInstance;

  List<NatSession> get session => $_getList(0);
}

class NatSession extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('NatSession', package: const $pb.PackageName('com.yongf.flutter.packetcaptureflutter.model'))
    ..aOS(1, 'type')
    ..aOS(2, 'ipAndPort')
    ..a<int>(3, 'remoteIP', $pb.PbFieldType.O3)
    ..a<int>(4, 'localIP', $pb.PbFieldType.O3)
    ..a<int>(5, 'remotePort', $pb.PbFieldType.O3)
    ..aOS(6, 'remoteHost')
    ..a<int>(7, 'localPort', $pb.PbFieldType.O3)
    ..a<int>(8, 'bytesSent', $pb.PbFieldType.O3)
    ..a<int>(9, 'packetSent', $pb.PbFieldType.O3)
    ..aInt64(10, 'receivedByteNum')
    ..aInt64(11, 'receivedPacketNum')
    ..aInt64(12, 'lastRefreshTime')
    ..aOB(13, 'isHttpsSession')
    ..aOS(14, 'requestUrl')
    ..aOS(15, 'path')
    ..aOS(16, 'method')
    ..aInt64(17, 'connectionStartTime')
    ..aInt64(18, 'vpnStartTime')
    ..aOB(19, 'isHttp')
    ..aOS(20, 'uniqueName')
    ..a<AppInfo>(21, 'appInfo', $pb.PbFieldType.OM, AppInfo.getDefault, AppInfo.create)
    ..hasRequiredFields = false
  ;

  NatSession() : super();
  NatSession.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NatSession.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NatSession clone() => new NatSession()..mergeFromMessage(this);
  NatSession copyWith(void Function(NatSession) updates) => super.copyWith((message) => updates(message as NatSession));
  $pb.BuilderInfo get info_ => _i;
  static NatSession create() => new NatSession();
  NatSession createEmptyInstance() => create();
  static $pb.PbList<NatSession> createRepeated() => new $pb.PbList<NatSession>();
  static NatSession getDefault() => _defaultInstance ??= create()..freeze();
  static NatSession _defaultInstance;

  String get type => $_getS(0, '');
  set type(String v) { $_setString(0, v); }
  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  String get ipAndPort => $_getS(1, '');
  set ipAndPort(String v) { $_setString(1, v); }
  bool hasIpAndPort() => $_has(1);
  void clearIpAndPort() => clearField(2);

  int get remoteIP => $_get(2, 0);
  set remoteIP(int v) { $_setSignedInt32(2, v); }
  bool hasRemoteIP() => $_has(2);
  void clearRemoteIP() => clearField(3);

  int get localIP => $_get(3, 0);
  set localIP(int v) { $_setSignedInt32(3, v); }
  bool hasLocalIP() => $_has(3);
  void clearLocalIP() => clearField(4);

  int get remotePort => $_get(4, 0);
  set remotePort(int v) { $_setSignedInt32(4, v); }
  bool hasRemotePort() => $_has(4);
  void clearRemotePort() => clearField(5);

  String get remoteHost => $_getS(5, '');
  set remoteHost(String v) { $_setString(5, v); }
  bool hasRemoteHost() => $_has(5);
  void clearRemoteHost() => clearField(6);

  int get localPort => $_get(6, 0);
  set localPort(int v) { $_setSignedInt32(6, v); }
  bool hasLocalPort() => $_has(6);
  void clearLocalPort() => clearField(7);

  int get bytesSent => $_get(7, 0);
  set bytesSent(int v) { $_setSignedInt32(7, v); }
  bool hasBytesSent() => $_has(7);
  void clearBytesSent() => clearField(8);

  int get packetSent => $_get(8, 0);
  set packetSent(int v) { $_setSignedInt32(8, v); }
  bool hasPacketSent() => $_has(8);
  void clearPacketSent() => clearField(9);

  Int64 get receivedByteNum => $_getI64(9);
  set receivedByteNum(Int64 v) { $_setInt64(9, v); }
  bool hasReceivedByteNum() => $_has(9);
  void clearReceivedByteNum() => clearField(10);

  Int64 get receivedPacketNum => $_getI64(10);
  set receivedPacketNum(Int64 v) { $_setInt64(10, v); }
  bool hasReceivedPacketNum() => $_has(10);
  void clearReceivedPacketNum() => clearField(11);

  Int64 get lastRefreshTime => $_getI64(11);
  set lastRefreshTime(Int64 v) { $_setInt64(11, v); }
  bool hasLastRefreshTime() => $_has(11);
  void clearLastRefreshTime() => clearField(12);

  bool get isHttpsSession => $_get(12, false);
  set isHttpsSession(bool v) { $_setBool(12, v); }
  bool hasIsHttpsSession() => $_has(12);
  void clearIsHttpsSession() => clearField(13);

  String get requestUrl => $_getS(13, '');
  set requestUrl(String v) { $_setString(13, v); }
  bool hasRequestUrl() => $_has(13);
  void clearRequestUrl() => clearField(14);

  String get path => $_getS(14, '');
  set path(String v) { $_setString(14, v); }
  bool hasPath() => $_has(14);
  void clearPath() => clearField(15);

  String get method => $_getS(15, '');
  set method(String v) { $_setString(15, v); }
  bool hasMethod() => $_has(15);
  void clearMethod() => clearField(16);

  Int64 get connectionStartTime => $_getI64(16);
  set connectionStartTime(Int64 v) { $_setInt64(16, v); }
  bool hasConnectionStartTime() => $_has(16);
  void clearConnectionStartTime() => clearField(17);

  Int64 get vpnStartTime => $_getI64(17);
  set vpnStartTime(Int64 v) { $_setInt64(17, v); }
  bool hasVpnStartTime() => $_has(17);
  void clearVpnStartTime() => clearField(18);

  bool get isHttp => $_get(18, false);
  set isHttp(bool v) { $_setBool(18, v); }
  bool hasIsHttp() => $_has(18);
  void clearIsHttp() => clearField(19);

  String get uniqueName => $_getS(19, '');
  set uniqueName(String v) { $_setString(19, v); }
  bool hasUniqueName() => $_has(19);
  void clearUniqueName() => clearField(20);

  AppInfo get appInfo => $_getN(20);
  set appInfo(AppInfo v) { setField(21, v); }
  bool hasAppInfo() => $_has(20);
  void clearAppInfo() => clearField(21);
}

class AppInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('AppInfo', package: const $pb.PackageName('com.yongf.flutter.packetcaptureflutter.model'))
    ..aOS(1, 'appName')
    ..aOS(2, 'packageName')
    ..a<List<int>>(3, 'icon', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  AppInfo() : super();
  AppInfo.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AppInfo.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AppInfo clone() => new AppInfo()..mergeFromMessage(this);
  AppInfo copyWith(void Function(AppInfo) updates) => super.copyWith((message) => updates(message as AppInfo));
  $pb.BuilderInfo get info_ => _i;
  static AppInfo create() => new AppInfo();
  AppInfo createEmptyInstance() => create();
  static $pb.PbList<AppInfo> createRepeated() => new $pb.PbList<AppInfo>();
  static AppInfo getDefault() => _defaultInstance ??= create()..freeze();
  static AppInfo _defaultInstance;

  String get appName => $_getS(0, '');
  set appName(String v) { $_setString(0, v); }
  bool hasAppName() => $_has(0);
  void clearAppName() => clearField(1);

  String get packageName => $_getS(1, '');
  set packageName(String v) { $_setString(1, v); }
  bool hasPackageName() => $_has(1);
  void clearPackageName() => clearField(2);

  List<int> get icon => $_getN(2);
  set icon(List<int> v) { $_setBytes(2, v); }
  bool hasIcon() => $_has(2);
  void clearIcon() => clearField(3);
}

