import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packet_capture_flutter/pages/home/packet_list_page.dart';

/// 首页：请求列表
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        onPressed: () {},
        tooltip: '抓包',
        child: Icon(Icons.link_off),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
