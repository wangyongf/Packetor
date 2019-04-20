import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isWindowMode = false;
  bool _isBlockRequest = false;
  bool _isBlockResponse = false;
  bool _enablePerformanceMode = false;

  @override
  void initState() {
    super.initState();

    _isWindowMode = false;
    _isBlockRequest = false;
    _isBlockResponse = false;
    _enablePerformanceMode = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () {
                Fluttertoast.showToast(msg: "检查更新功能开发中，敬请期待");
              })
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              "抓包设置",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              "目标应用",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "全部",
              style: TextStyle(fontSize: 12),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              "目标 Host",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "全部",
              style: TextStyle(fontSize: 12),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              "SSL 证书管理",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "管理用于 SSL 请求的数字证书",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              "高级选项",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              "插件管理",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "插件管理器，可以添加、删除、启用和禁用插件",
              style: TextStyle(fontSize: 12),
            ),
          ),
          SwitchListTile(
            onChanged: (bool value) {
              setState(() {
                _isWindowMode = value;
              });
            },
            value: _isWindowMode,
            title: Text(
              "窗口模式",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "抓包过程中如果应用退回到后台，显示一个 mini 悬浮窗",
              style: TextStyle(fontSize: 12),
            ),
          ),
          SwitchListTile(
            onChanged: (bool value) {
              setState(() {
                _isBlockRequest = value;
              });
            },
            value: _isBlockRequest,
            title: Text(
              "屏蔽请求",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "如果打开此开关，客户端的 http 请求将不会发给服务器",
              style: TextStyle(fontSize: 12),
            ),
          ),
          SwitchListTile(
            onChanged: (bool value) {
              setState(() {
                _isBlockResponse = value;
              });
            },
            value: _isBlockResponse,
            title: Text(
              "屏蔽响应",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "如果打开此开关，服务器的 http 响应将不会返给客户端",
              style: TextStyle(fontSize: 12),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              "DNS 服务器",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "暂未配置",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              "其它选项",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            onChanged: (bool value) {
              setState(() {
                _enablePerformanceMode = value;
              });
            },
            value: _enablePerformanceMode,
            title: Text(
              "性能模式",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "开启性能模式后，将会降低抓包时手机电量消耗，但代价是无法获取应用信息",
              style: TextStyle(fontSize: 12),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              "安装平行空间",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "建议使用平行空间打开目标应用抓取 https 数据包",
              style: TextStyle(fontSize: 12),
            ),
          ),
          ListTile(
            onTap: () {
              Fluttertoast.showToast(msg: "缓存清除成功");
            },
            title: Text(
              "清除缓存",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            subtitle: Text(
              "缓存文件大小 ${_getReadableSize()}",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  String _getReadableSize() {
    return "23.92KB";
  }
}
