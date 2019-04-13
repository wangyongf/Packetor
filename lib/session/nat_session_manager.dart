import 'package:flutter/services.dart';

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
  MethodChannel _sessionChannel =
      MethodChannel('flutter.yongf.com/pcf/session');

  Future<dynamic> requestSessions() async {
    await _channel.invokeMethod("transfer");
  }

  Future<dynamic> requestSession(String dir) async {
    var param = {'session_dir': dir};
    await _sessionChannel.invokeMethod('transferSessionByDir', Map.of(param));
  }
}
