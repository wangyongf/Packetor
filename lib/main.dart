import 'package:flutter/material.dart';
import 'package:packet_capture_flutter/pages/packet_detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Packet Capture Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: HomePage(title: 'Packet Capture Flutter'),
      home: PacketDetailPage(),
    );
  }
}
