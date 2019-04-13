import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:packet_capture_flutter/common/constants.dart';
import 'package:packet_capture_flutter/model/nat_session.pb.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_page.dart';
import 'package:packet_capture_flutter/utils/TimeFormatUtil.dart';

class PacketListPage extends StatefulWidget {
  final NatSessions sessions;

  const PacketListPage({Key key, this.sessions}) : super(key: key);

  @override
  _PacketListPageState createState() => _PacketListPageState();
}

class _PacketListPageState extends State<PacketListPage> {
  var _random;

  @override
  void initState() {
    super.initState();
    _random = Random();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(),
    );
  }

  _buildBody() {
    return ListView.separated(
        itemCount: widget.sessions?.session?.length ?? 0,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int position) {
          return _buildItem(context, position);
        });
  }

  _buildItem(BuildContext context, int position) {
    var next = _random.nextInt(10);
    return InkWell(
      onTap: () {
        _gotoPacketDetailPage(position);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 8),
              child: _getIcon(position),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.sessions?.session[position]?.appInfo?.appName ??
                            '未知应用',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Text(
                          '${formatDate(widget.sessions?.session[position]?.connectionStartTime)}',
                          style: TextStyle(color: Colors.black38, fontSize: 14),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          _getSessionType(widget.sessions?.session[position])
                              .toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            _getSessionUrl(widget.sessions?.session[position]),
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            _getSessionState(
                                widget.sessions?.session[position]),
                            style: TextStyle(
                                color: next > 5
                                    ? Colors.blueAccent
                                    : Colors.orange,
                                fontSize: 15),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            _getTransferDataSize(
                                widget.sessions?.session[position]),
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTransferDataSize(NatSession session) {
    if (session == null) {
      return '';
    }
    int sumByte = session.bytesSent + session.receivedByteNum.toInt();
    String size = '';
    if (sumByte > (2 << 20)) {
      size = (sumByte / ((2 << 20) * 1.0) + 0.5).toString() + "MB";
    } else if (sumByte > (2 << 10)) {
      size = (sumByte / ((2 << 10) * 1.0) + 0.5).toString() + "KB";
    } else {
      size = sumByte.toString() + "B";
    }
    return size;
  }

  String _getSessionState(NatSession session) {
    if (session == null) {
      return '无响应';
    }
    if (session.receivedByteNum > 0) {
      return '200 OK';
    } else {
      return '无响应';
    }
  }

  String _getSessionType(NatSession session) {
    if (session == null) {
      return 'unknown';
    }
    String type = session.type;
    if (session.type == 'TCP') {
      type = session.method;
    }
    if (type == null || type.isEmpty) {
      type = 'TYPE';
    }
    return type;
  }

  String _getSessionUrl(NatSession session) {
    if (session == null) {
      return 'some host';
    }
    String url = session.remoteHost;
    if (session.type == 'TCP' && session.requestUrl.isNotEmpty) {
      url = session.requestUrl;
    }
    return url;
  }

  String _getIpAndPort(NatSession session) {
    if (session == null) {
      return 'unknown host';
    }
    return session.ipAndPort;
  }

  Widget _getIcon(int position) {
    if (widget.sessions == null) {
      return Container();
    }
    return Image.memory(
      widget.sessions.session[position].appInfo.icon,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      gaplessPlayback: true,
    );
  }

  String formatDate(Int64 time) {
    if (time == null) {
      return '';
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time.toInt());
    var formatter = DateFormat('HH:mm:ss');
    return formatter.format(dateTime);
  }

  _gotoPacketDetailPage(int position) {
    NatSession session = widget.sessions.session[position];
    if (session.type != Constants.TCP) {
      Fluttertoast.showToast(msg: '暂时只支持查看 TCP 类型请求');
      return;
    }

    /// TODO: fix 请求数据目录不正确的问题
    String dir = Constants.DATA_DIR +
        TimeFormatUtil.format(widget.sessions.session[position].vpnStartTime) +
        "/" +
        widget.sessions.session[position].uniqueName;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PacketDetailPage(
        sessions: widget.sessions,
        index: position,
        sessionPath: dir,
      );
    }));
  }
}
