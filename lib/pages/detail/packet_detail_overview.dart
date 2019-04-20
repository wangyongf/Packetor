import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packet_capture_flutter/model/nat_session.pb.dart';
import 'package:packet_capture_flutter/model/nat_session_request.pb.dart';
import 'package:packet_capture_flutter/pages/detail/url_preview_page.dart';

class PacketDetailOverview extends StatefulWidget {
  final NatSessions sessions;
  final int index;
  final NatSessionRequest request;

  const PacketDetailOverview({Key key, this.sessions, this.index, this.request})
      : super(key: key);

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
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return UrlPreviewPage(url: _getRequestUrl(),);
                  }));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _getRequestUrl(),
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _divider(),
            _divider(),
            _buildStatusItem('是否注入', _getInjectStatus()),
            _divider(),
            _buildStatusItem('isRequest', _isRequest()),
//            _divider(),
//            _buildStatusItem('headStr', _getHeadStr()),
//            _divider(),
//            _buildStatusItem('bodyStr', _getBodyStr()),
//            _divider(),
//            _buildStatusItem('bodyImage', _getBodyImage()),
            _divider(),
            _buildStatusItem('Protocol', _getProtocol()),
            _divider(),
            _buildStatusItem('host', _getRemoteHost()),
            _divider(),
            _buildStatusItem('Content-Type ↑', _getContentTypeUpStream()),
            _divider(),
            _buildStatusItem('Content-Type ↓', _getContentTypeDownStream()),
            _divider(),
            _buildStatusItem('Server IP', _getRemoteIP()),
            _buildTitle('时间'),
            _buildStatusItem('开始时间', _getRequestStartTime()),
            _divider(),
            _buildStatusItem('结束时间', _getRequestEndTime()),
            _divider(),
            _buildStatusItem('总时长', _getRequestDuration()),
            _buildTitle('数据量'),
            _buildStatusItem('请求', _getRequestDataSize()),
            _divider(),
            _buildStatusItem('响应', _getResponseDataSize()),
            _divider(),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  /// TODO: 优化 header, body 的 UI 展示
  String _isRequest() {
    return widget.request?.isRequest.toString() ?? '';
  }

  String _getHeadStr() {
    return widget.request?.headStr ?? '';
  }

  String _getBodyStr() {
    return widget.request?.bodyStr ?? '';
  }

  String _getBodyImage() {
    var image = widget.request?.bodyImage;
    var length = 0;
    if (image != null) {
      length = image.length;
    }
    return length > 0 ? 'true' : 'false';
  }

  String _getResponseDataSize() {
    return widget.sessions.session[widget.index].receivedByteNum.toString() +
      "B" ??
        '245B';
  }

  String _getRequestDataSize() {
    return widget.sessions.session[widget.index].bytesSent.toString() + "B" ??
        '0.94KB';
  }

  String _getRequestDuration() {
    return '372ms';
  }

  String _getRequestEndTime() {
    return '2019-01-02 00:21:39.722';
  }

  String _getRequestStartTime() {
    return DateTime.fromMillisecondsSinceEpoch(widget
                .sessions.session[widget.index].connectionStartTime
                .toInt())
            .toIso8601String() ??
        '2019-01-02 00:21:39.350';
  }

  String _getRemoteIP() {
    return widget.sessions.session[widget.index].remoteIP.toString() ??
        '127.0.0.1:8080';
  }

  String _getContentTypeDownStream() {
    return 'application/json';
  }

  String _getContentTypeUpStream() {
    return 'application/json';
  }

  String _getRemoteHost() {
    return widget.sessions.session[widget.index].remoteHost ??
        'https://www.baidu.com';
  }

  String _getProtocol() {
    return 'HTTP/1.1';
  }

  String _getResponseCode() {
    return '200 OK';
  }

  String _getInjectStatus() {
    return 'false';
  }

  String _getRequestUrl() {
    var requestUrl = widget.sessions.session[widget.index].requestUrl;
    if (requestUrl == null || requestUrl.isEmpty) {
      var host = widget.sessions.session[widget.index].remoteHost;
      if (host != null && host.isNotEmpty) {
        return host;
      }
      return "https://blog.54yongf.com";
    }
    return requestUrl;
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
    return InkWell(
      onTap: () {
        _showDetailDialog(key, value);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Text(
                key,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              flex: 1,
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              flex: 2,
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
          content: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(value),
            ],
          ),
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
