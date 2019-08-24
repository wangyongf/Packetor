import 'dart:async';

import 'package:flutter/services.dart';
import 'package:packet_capture_flutter/model/nat_session.pb.dart';
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

  String get _sessionChannel {
    return 'flutter.yongf.com/pcf/session';
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

  Future<dynamic> requestSessionByDir(String dir) async {
    if (dir == null || dir.isEmpty) {
      return null;
    }
    Completer completer = Completer();
    BinaryMessages.setMessageHandler(_sessionChannel, (ByteData message) {
      completer.complete(message);
      BinaryMessages.setMessageHandler(_sessionChannel, null);
    });
    NatSessionManager().requestSession(dir);
    return completer.future;
  }

  Future<dynamic> saveSession(NatSession session, String dir) async {
    if (session == null || dir == null || dir.isEmpty) {
      return null;
    }
    return await NatSessionManager().saveSession(session, dir);
  }
}
