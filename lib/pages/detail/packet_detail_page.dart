import 'package:flutter/material.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_overview.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_request.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_response.dart';
import 'package:share/share.dart';

class PacketDetailPage extends StatefulWidget {
  @override
  _PacketDetailPageState createState() => _PacketDetailPageState();
}

class _PacketDetailPageState extends State<PacketDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
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
          SizedBox(
              width: 60,
              child: InkWell(
                  onTap: () {
                    Share.share(
                        'Check out my new app - Packet Capture Flutter');
                  },
                  child: Icon(Icons.share))),
          SizedBox(
              width: 60,
              child: InkWell(onTap: () {}, child: Icon(Icons.favorite_border)))
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
      PacketDetailOverview(),
      PacketDetailRequest(),
      PacketDetailResponse(),
    ]);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }
}
