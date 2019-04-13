import 'package:flutter/material.dart';
import 'package:packet_capture_flutter/model/nat_session.pb.dart';
import 'package:packet_capture_flutter/model/nat_session_request.pb.dart';

class PacketDetailResponse extends StatefulWidget {
  final NatSessions sessions;
  final int index;
  final NatSessionRequest request;

  const PacketDetailResponse({Key key, this.sessions, this.index, this.request})
      : super(key: key);

  @override
  _PacketDetailResponseState createState() => _PacketDetailResponseState();
}

class _PacketDetailResponseState extends State<PacketDetailResponse> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
