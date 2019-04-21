import 'package:flutter/material.dart';
import 'package:packet_capture_flutter/common/routes.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_page.dart';
import 'package:packet_capture_flutter/pages/home/home_page.dart';
import 'package:packet_capture_flutter/pages/test_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Packetor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        Routes.HOME_PAGE: (BuildContext context) =>
            HomePage(title: 'Packetor'),
        Routes.PACKET_DETAIL_PAGE: (BuildContext context) => PacketDetailPage(),
        Routes.TEST_PAGE: (BuildContext context) => TestPage(),
      },
      home: HomePage(title: 'Packetor'),
//      home: TestPage(),
//      home: PacketDetailPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
