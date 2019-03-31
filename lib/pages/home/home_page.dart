import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packet_capture_flutter/model/nat_session.pb.dart';
import 'package:packet_capture_flutter/pages/home/packet_list_page.dart';
import 'package:packet_capture_flutter/session/nat_session_delegate.dart';
import 'package:packet_capture_flutter/widget/sexy_fab.dart';

/// 首页：请求列表
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _platform = MethodChannel('pcf.flutter.yongf.com/battery');
  var _pcf = MethodChannel('flutter.yongf.com/pcf');
  String _batteryLevel = 'Unknown battery level.';
  bool _isPacketMode = false;
  String _title = '';
  NatSessions _protobuf;

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
    _title = widget.title;
    _platform.setMethodCallHandler(_handleMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: () {}, child: Icon(Icons.menu)),
        title: Text(
          _title,
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
      body: _buildBody(),

      /// FIXME: 14:53:10.471 1 info flutter.tools I/flutter (12584): Another exception was thrown: There are multiple heroes that share the same tag within a subtree.
      floatingActionButton: SexyFab(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return _buildSexyFab(index);
        },
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _refreshSessions,
//        tooltip: '抓包',
//        child: _isPacketMode ? Icon(Icons.link) : Icon(Icons.link_off),
//      ),
    );
  }

  Widget _buildSexyFab(int index) {
    switch (index) {
      case 0:
        return _vpn();
      case 1:
        return _image();
      case 2:
        return _inbox();
    }
    return Container();
  }

  Widget _vpn() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'vpn',
        onPressed: _changeVpnStatus,
        tooltip: 'VPN',
        child: !_isPacketMode ? Icon(Icons.link) : Icon(Icons.link_off),
      ),
    );
  }

  Widget _image() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'image',
        onPressed: _refreshSessions,
        tooltip: 'Image',
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _inbox() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'inbox',
        onPressed: null,
        tooltip: 'Inbox',
        child: Icon(Icons.inbox),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: PacketListPage(
        sessions: _protobuf,
      ),
    );
  }

  Future<void> _refreshSessions() async {
    var result;
    try {
      if (!_isPacketMode) {
        await _changeVpnStatus();
      }
      NatSessionDelegate delegate = NatSessionDelegate();
      ByteData message = await delegate.requestSessions();
      List<int> bytes = message.buffer
          .asUint8List(message.offsetInBytes, message.lengthInBytes);
      result = NatSessions.fromBuffer(bytes);
    } on PlatformException catch (e) {
      debugPrint('PlatformException: ${e.message}');
    }
    setState(() {
      _protobuf = result;
    });
  }

  Future<void> _changeVpnStatus() async {
    bool expected = !_isPacketMode;
    try {
      if (expected) {
        await _platform.invokeMethod('startVPN');
      } else {
        await _platform.invokeMethod('stopVPN');
      }
    } on PlatformException catch (e) {
      debugPrint("PlatformException: ${e.message}");
    }
    setState(() {
      this._isPacketMode = expected;
    });
  }
}
