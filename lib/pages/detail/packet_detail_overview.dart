import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PacketDetailOverview extends StatefulWidget {
  @override
  _PacketDetailOverviewState createState() => _PacketDetailOverviewState();
}

class _PacketDetailOverviewState extends State<PacketDetailOverview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                'http://8.wacai.com/finance.do',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            _divider(),
            _divider(),
            _buildStatusItem('注入', 'false'),
            _divider(),
            _buildStatusItem('响应码', '200'),
            _divider(),
            _buildStatusItem('协议', 'HTTP/1.1'),
            _divider(),
            _buildStatusItem('host', 'https://8.wacai.com'),
            _divider(),
            _buildStatusItem('Content-Type ↑', 'application/json'),
            _divider(),
            _buildStatusItem('Content-Type ↓', 'application/json'),
            _divider(),
            _buildStatusItem('Server IP', '127.0.0.1:8080'),
            _buildTitle('时间'),
            _buildStatusItem('开始时间', '2019-01-02 00:21:39.350'),
            _divider(),
            _buildStatusItem('结束时间', '2019-01-02 00:21:39.722'),
            _divider(),
            _buildStatusItem('总时长', '372ms'),
            _buildTitle('数据量'),
            _buildStatusItem('请求', '0.94KB'),
            _divider(),
            _buildStatusItem('响应', '245B'),
            _divider(),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Container _buildTitle(String title) {
    return Container(
      width: double.infinity,
      color: Colors.grey.withAlpha(70),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
    );
  }

  _buildStatusItem(String key, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      child: InkWell(
        onTap: () {
          _showDetailDialog(key, value);
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Text(
                key,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              flex: 5,
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              flex: 9,
            )
          ],
        ),
      ),
    );
  }

  _divider() {
    return Divider(
      height: 1,
    );
  }

  _showDetailDialog(String key, String value) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: Text(key),
                content: Text(value),
                actions: <Widget>[
                  FlatButton(
                    child: Text("复制"),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: value));
                      Fluttertoast.showToast(msg: '已复制至粘贴板');
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("关闭"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]));
  }
}
