import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:packet_capture_flutter/http/HttpResponse.dart';
import 'package:packet_capture_flutter/model/nat_session_request.pb.dart';
import 'package:packet_capture_flutter/pages/detail/packet_detail_bottom_radio.dart';

class PacketDetailResponse extends StatefulWidget {
  final NatSessionRequest response;

  const PacketDetailResponse({Key key, this.response})
      : super(key: key);

  @override
  _PacketDetailResponseState createState() => _PacketDetailResponseState();
}

class _PacketDetailResponseState extends State<PacketDetailResponse> {
  int _current = 0;
  List<String> _options = List<String>();

  @override
  void initState() {
    super.initState();

    _options.add("Raw");
    _options.add("Headers");
    _options.add("Text");
    _options.add("Hex");
    _options.add("Preview");
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

  Widget _getWidgetForPosition(int position) {
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
    return widget.response?.headStr ?? "";
  }

  Map<String, String> _getHeaderMap() {
    HttpRequest request = HttpRequest.parse(widget.response?.headStr ?? "");
    return request.getHeaders();
  }

  _getHeadersOption() {
    List<Widget> headers = List();
    _getHeaderMap()?.forEach((String key, String value) {
      var single = _getHeader(key, value);
      headers.add(single);
      headers.add(Divider());
    });
    if (headers.length == 0) {
      return Center(
        child: Text("无数据"),
      );
    }
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
    var text = widget.response?.bodyStr ?? "无数据";
    if (text.isEmpty) {
      text = "无数据";
    }
    return Center(
      child: Container(
        child: Text(text),
      ),
    );
  }

  _getHexOption() {
    return Center(
      child: Text('功能开发中，敬请期待'),
    );
  }

  _getPreviewOption() {
    if (widget.response == null || widget.response.bodyStr == null
      || widget.response.bodyStr.isEmpty) {
      return Center(
        child: Text('不支持预览'),
      );
    }
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: "JSON");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.redAccent,
                      height: 120,
                      child: Center(
                        child: Text("JSON",
                          style: TextStyle(
                            color: Colors.white, fontSize: 18,),),
                      ),
                    ),
                  ),
                )),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: "Bitmap");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.lightBlue,
                      height: 120,
                      child: Center(
                        child: Text("Bitmap",
                          style: TextStyle(
                            color: Colors.white, fontSize: 18,),),
                      ),
                    ),
                  ),
                )),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: "XML");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.deepOrange,
                      height: 120,
                      child: Center(
                        child: Text("XML",
                          style: TextStyle(
                            color: Colors.white, fontSize: 18,),),
                      ),
                    ),
                  ),
                )),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: "敬请期待~");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.green,
                      height: 120,
                      child: Center(
                        child: Text("敬请期待",
                          style: TextStyle(
                            color: Colors.white, fontSize: 18,),),
                      ),
                    ),
                  ),
                )),
            ],
          ),
        ],
      ),
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
      builder: (_) =>
        AlertDialog(
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
