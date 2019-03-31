import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:packet_capture_flutter/common/routes.dart';
import 'package:packet_capture_flutter/model/nat_session.pb.dart';

class PacketListPage extends StatefulWidget {
  final NatSessions sessions;

  const PacketListPage({Key key, this.sessions}) : super(key: key);

  @override
  _PacketListPageState createState() => _PacketListPageState();
}

class _PacketListPageState extends State<PacketListPage> {
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
    return InkWell(
      onTap: () {
        _gotoPacketDetailPage();
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
                            'Unknown App',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Text(
                          '${formatDate(widget.sessions?.session[position]?.connectionStartTime)}',
                          style: TextStyle(color: Colors.black38, fontSize: 16),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.sessions?.session[position]?.method
                              ?.toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            widget.sessions?.session[position]?.requestUrl,
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
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '200 OK',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  _gotoPacketDetailPage() {
    Navigator.of(context).pushNamed(Routes.PACKET_DETAIL_PAGE);
  }
}
