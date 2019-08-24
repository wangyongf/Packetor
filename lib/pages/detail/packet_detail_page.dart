import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packet_capture_flutter/model/nat_session.pb.dart';
import 'package:packet_capture_flutter/model/nat_session_request.pb.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_overview.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_request.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_response.dart';
import 'package:packet_capture_flutter/session/nat_session_delegate.dart';
import 'package:share/share.dart';

class PacketDetailPage extends StatefulWidget {
  final NatSessions sessions;
  final int index;
  final String sessionPath;

  const PacketDetailPage({Key key, this.sessions, this.index, this.sessionPath})
      : super(key: key);

  @override
  _PacketDetailPageState createState() => _PacketDetailPageState();
}

class _PacketDetailPageState extends State<PacketDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  NatSessionRequests _sessionRequests;

  // TODO: NatSessionResponses

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _refreshSession();
  }

  Future<void> _refreshSession() async {
    var result;
    try {
      ByteData message = await NatSessionDelegate().requestSessionByDir(
        widget.sessionPath);
      List<int> bytes = message.buffer
          .asUint8List(message.offsetInBytes, message.lengthInBytes);
      result = NatSessionRequests.fromBuffer(bytes);
    } on PlatformException catch (e) {
      debugPrint('PlatformException: ${e.message}');
    }
    setState(() {
      _sessionRequests = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text(
          '抓包内容',
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () {
            Share.share(
              'Check out my new app - Packet Capture Flutter');
          }),
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () async {
            await _saveSession();
          }),
        ],
        bottom: _buildBottom(),
      ),
      body: _buildBody(),
    );
  }

  _buildBottom() {
    return TabBar(controller: _tabController, tabs: <Widget>[
      Tab(
        text: "总览",
      ),
      Tab(
        text: "请求",
      ),
      Tab(
        text: "响应",
      ),
    ]);
  }

  _buildBody() {
    return TabBarView(controller: _tabController, children: <Widget>[
      PacketDetailOverview(
        sessions: widget.sessions,
        index: widget.index,
        request: _sessionRequests?.request != null ? _sessionRequests?.request[0] : null,
      ),
      PacketDetailRequest(
        request: _retrieveRequest(),
      ),
      PacketDetailResponse(
        response: _retrieveResponse(),
      ),
    ]);
  }

  /// 从列表中获取第一个类型是 request 的
  NatSessionRequest _retrieveRequest() {
    if (_sessionRequests == null) {
      return null;
    }
    for (var request in _sessionRequests.request) {
      if (request != null && request.isRequest) {
        return request;
      }
    }
    return null;
  }

  /// 从列表中获取第一个类型是 response 的
  NatSessionRequest _retrieveResponse() {
    if (_sessionRequests == null) {
      return null;
    }
    for (var response in _sessionRequests.request) {
      if (response != null && !response.isRequest) {
        return response;
      }
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  _saveSession() async {
    try {
      bool result = await NatSessionDelegate().saveSession(null, null);
      Fluttertoast.showToast(msg: result ? "成功了" : "失败了");
    } on PlatformException catch (e) {
      /// TODO: 错误处理
      Fluttertoast.showToast(msg: "异常了，${e.message}");
    }
  }
}
