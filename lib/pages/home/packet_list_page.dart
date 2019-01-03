import 'package:flutter/material.dart';
import 'package:packet_capture_flutter/common/routes.dart';

class PacketListPage extends StatefulWidget {
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
        itemCount: 5,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int position) {
          return _buildItem(context);
        });
  }

  _buildItem(BuildContext context) {
    return InkWell(
      onTap: () {
        _gotoPacketDetailPage();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.android,
                size: 50,
                color: Colors.black87,
              ),
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
                        '抖音短视频',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '23:43:56',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  Text(
                    'POST http://8.wacai.com',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    '200 OK',
                    style:
                        TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _gotoPacketDetailPage() {
    Navigator.pushNamed(context, Routes.PACKET_DETAIL_PAGE);
  }
}
