import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:packet_capture_flutter/model/nat_session.pb.dart';

class NatSessionManager {
  /// The resource identifier
  String _identifier;

  /// The resource file name
  String _name;

  /// 单例模式
  static final NatSessionManager _singleton = NatSessionManager._internal();

  factory NatSessionManager() {
    return _singleton;
  }

  NatSessionManager._internal();

  MethodChannel _channel = MethodChannel('flutter.yongf.com/pcf');
  static String _sessionChannelName = "flutter.yongf.com/pcf/session";
  MethodChannel _sessionChannel = MethodChannel(_sessionChannelName);

  Future<dynamic> requestSessions() async {
    await _channel.invokeMethod("transfer");
  }

  Future<dynamic> requestSession(String dir) async {
    var param = {'session_dir': dir};
    await _sessionChannel.invokeMethod('transferSessionByDir', Map.of(param));
  }

  Future<dynamic> saveSession(NatSession session, String dir) async {
    Uint8List list = session.writeToBuffer();
    var data = ByteData.view(list.buffer);
    await BinaryMessages.send(_sessionChannelName, data);
    var param = {"dir": dir};
    return await _sessionChannel.invokeMethod("saveSession", Map.of(param));
  }
}
