import 'package:flutter/material.dart';

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
              width: 40,
              height: 40,
              child: InkWell(onTap: () {}, child: Icon(Icons.share))),
          SizedBox(
              width: 40,
              height: 40,
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
      Center(
        child: Text('总览'),
      ),
      Center(
        child: Text('请求'),
      ),
      Center(
        child: Text('响应'),
      ),
    ]);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }
}
