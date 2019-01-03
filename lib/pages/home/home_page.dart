import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packet_capture_flutter/pages/home/packet_list_page.dart';
import 'package:permission/permission.dart';

/// 首页：请求列表
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _platform = MethodChannel('pcf.flutter.yongf.com/battery');
  String _batteryLevel = 'Unknown battery level.';
  bool _isPacketMode = false;

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await _platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = 'Failed to get battery level: ${e.message}';
    }

    setState(() {
      this._batteryLevel = batteryLevel;
    });
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "refresh":
        debugPrint(call.arguments);
        return Future.value("Success from Dart");
    }
  }

  @override
  void initState() {
    super.initState();

    _isPacketMode = false;
    _platform.setMethodCallHandler(_handleMethod);
    _checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: () {}, child: Icon(Icons.menu)),
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          SizedBox(
              width: 60,
              child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: '「高级搜索功能开发中」');
                  },
                  child: Icon(Icons.youtube_searched_for))),
          SizedBox(
              width: 60,
              child: InkWell(onTap: () {}, child: Icon(Icons.layers_clear)))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5),
        child: PacketListPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
//          _getBatteryLevel();
          _changeVpnStatus();
        },
        tooltip: '抓包',
        child: _isPacketMode ? Icon(Icons.link) : Icon(Icons.link_off),
//        child: Text(_batteryLevel),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _checkPermissions() async {
    await Permission.requestPermissions([PermissionName.Storage]);
  }

  _changeVpnStatus() async {
    bool expected = !_isPacketMode;
    setState(() {
      this._isPacketMode = expected;
    });

    /// TODO: Dart2 中 async await 的使用方法？
    /// TODO: App 中的 UncaughtExceptionHandler，用于调试，支付 SDK 中有一个现成的？
    try {
      if (expected) {
        await _platform.invokeMethod('startVPN');
      } else {
        await _platform.invokeMethod('stopVPN');
      }
    } on PlatformException catch (e) {
      debugPrint("PlatformException: ${e.message}");
//      expected = !_isPacketMode;
    }
  }
}
