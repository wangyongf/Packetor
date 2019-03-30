import 'package:flutter/material.dart';
import 'package:packet_capture_flutter/common/routes.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_page.dart';
import 'package:packet_capture_flutter/pages/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Packet Capture Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        Routes.HOME_PAGE: (BuildContext context) =>
            HomePage(title: 'Packet Capture Flutter'),
        Routes.PACKET_DETAIL_PAGE: (BuildContext context) => PacketDetailPage(),
      },
      home: HomePage(title: 'Packet Capture Flutter'),
//      home: PacketDetailPage(),
    );
  }
}
