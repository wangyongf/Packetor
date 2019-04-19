import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packet_capture_flutter/http/HttpResponse.dart';
import 'package:packet_capture_flutter/model/nat_session_request.pb.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_bottom_radio.dart';

class PacketDetailRequest extends StatefulWidget {
  final NatSessionRequest request;

  const PacketDetailRequest({Key key, this.request})
      : super(key: key);

  @override
  _PacketDetailRequestState createState() => _PacketDetailRequestState();
}

class _PacketDetailRequestState extends State<PacketDetailRequest> {
  int _current = 0;
  List<String> _options = List<String>();

  @override
  void initState() {
    super.initState();

    _options.add('Raw');
    _options.add('Headers');
    _options.add('Text');
    _options.add('Hex');
    _options.add('Preview');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 16),
            child: _getWidgetForPosition(_current),
          )),
          PacketDetailBottomRadioGroup(
            length: _options.length,
            selected: _current,
            onRadioSelect: (int position) {
              _onChangeOption(position);
            },
            radioBuilder: (int position) {
              return Tooltip(
                message: _options[position],
                child: Text(
                  _options[position],
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _getWidgetForPosition(int position) {
    switch (position) {
      case 0:
        return _getRawOption();
      case 1:
        return _getHeadersOption();
      case 2:
        return _getTextOption();
      case 3:
        return _getHexOption();
      case 4:
        return _getPreviewOption();
      default:
        throw Exception('Unsupported Position: $position');
    }
  }

  _getRawOption() {
    return Text(
      _buildRawText(),
      style: TextStyle(color: Colors.black, fontSize: 15),
    );
  }

  String _buildRawText() {
    return widget.request?.headStr ?? "";
  }

  String _buildRequestHeaders() {
    var result = "";
    return result;
  }

  Map<String, String> _getHeaderMap() {
    HttpRequest request = HttpRequest.parse(widget.request?.headStr ?? "");
    return request.getHeaders();
  }

  _getHeadersOption() {
    List<Widget> headers = List();
    _getHeaderMap()?.forEach((String key, String value) {
      var single = _getHeader(key, value);
      headers.add(single);
      headers.add(Divider());
    });
    return ListView(
      children: headers,
    );
  }

  _getHeader(String key, String value) {
    return InkWell(
      onTap: () {
        _showDetailDialog(key, value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.5),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                key + ': ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  _getTextOption() {
    return Center(
      child: Text('无数据'),
    );
  }

  _getHexOption() {
    return Center(
      child: Text('无数据'),
    );
  }

  _getPreviewOption() {
    return Center(
      child: Text('不支持预览'),
    );
  }

  _onChangeOption(int position) {
    if (_current == position) {
      return;
    }
    setState(() {
      this._current = position;
    });
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
