import 'dart:async';

import 'package:flutter/services.dart';
import 'package:packet_capture_flutter/session/nat_session_manager.dart';

class NatSessionDelegate {
  /// The resource identifier
  String _identifier;

  /// The resource file name
  String _name;

  /// Original data
  ByteData _data;

  /// The BinaryChannel name
  String get _channel {
    return 'flutter.yongf.com/pcf';
  }

  Future<dynamic> requestSessions() async {
    Completer completer = new Completer();
    BinaryMessages.setMessageHandler(_channel, (ByteData message) {
      _data = message;
      completer.complete(message);
      BinaryMessages.setMessageHandler(_channel, null);
    });

    NatSessionManager().requestSessions();
    return completer.future;
  }
}
