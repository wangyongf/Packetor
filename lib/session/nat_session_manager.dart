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

  Future<dynamic> requestSessions() async {
    await _channel.invokeMethod("transfer");
  }
}
