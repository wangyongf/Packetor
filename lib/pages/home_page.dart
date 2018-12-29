import 'package:flutter/material.dart';

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
              width: 40,
              height: 40,
              child: InkWell(
                  onTap: () {}, child: Icon(Icons.youtube_searched_for))),
          SizedBox(
              width: 40,
              height: 40,
              child: InkWell(onTap: () {}, child: Icon(Icons.layers_clear)))
        ],
      ),
      body: Center(
        child: Text(
          '点击右下角按钮开始抓包',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '抓包',
        child: Icon(Icons.link_off),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
