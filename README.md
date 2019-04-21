# packet_capture_flutter

Packet Capture Flutter

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Key Features

1. http 抓包
2. https 抓包
3. 网络请求会话保存
    1. powered by Android Jetpack#Room
4. tcpdump
5. 网络请求保存
    1. 保存为 url
    2. 保存为 curl request
    3. 保存为 charles 请求格式
    4. 保存为 postman 请求格式
    5. 保存为标准 HTTP 文本格式（参考 postman）
    6. 支持批量保存
6. 代码生成
    1. 生成C语言代码
    2. 生成 curl 请求
    3. 生成 C# 请求代码
    4. 生成 Go 请求代码
    5. 生成 Java 请求代码，支持 Okhttp, Retrofit
    6. 生成 JavaScript 请求代码，支持 ajax, xhr
    7. 生成 NodeJS 请求代码
    8. 生成 Objective-C 请求代码
    9. 生成 PHP 请求代码
    10. 生成 Python 请求代码
    11. 生成 Ruby 请求代码
    12. 生成 Shell 请求代码，支持 wget, Httpie, cURL
    13. 生成 Swift 请求代码
    14. 生成 Kotlin 请求代码
    15. 支持批量代码生成
7. Overview，参考 Charles
8. Request，参考 Charles
9. Response，参考 Charles
10. Summary，参考 Charles
11. Chart，参考 Charles
12. Notes，参考 Charles
13. 全面参考 Charles 的功能，移动端全能 Charles
14. 实现请求收藏功能
15. 实现请求重发功能

## 站在巨人的肩膀上

- [巨人1]()
- [巨人2]()
- [巨人3]()

## 数据结构

```json
[
  {
    "type": null,
    "ipAndPort": null,
    "remoteIP": 0,
    "localIP": 0,
    "remotePort": 0,
    "remoteHost": null,
    "localPort": 0,
    "bytesSent": 0,
    "packetSent": 0,
    "receivedByteNum": 0,
    "receivedPacketNum": 0,
    "lastRefreshTime": 0,
    "isHttpsSession": false,
    "requestUrl": null,
    "path": null,
    "method": null,
    "connectionStartTime": 1546621089025,
    "vpnStartTime": 0,
    "isHttp": false
  },
  {
    "type": null,
    "ipAndPort": null,
    "remoteIP": 0,
    "localIP": 0,
    "remotePort": 0,
    "remoteHost": null,
    "localPort": 0,
    "bytesSent": 0,
    "packetSent": 0,
    "receivedByteNum": 0,
    "receivedPacketNum": 0,
    "lastRefreshTime": 0,
    "isHttpsSession": false,
    "requestUrl": null,
    "path": null,
    "method": null,
    "connectionStartTime": 1546621089025,
    "vpnStartTime": 0,
    "isHttp": false
  }
]
```

## TODO List

1. 使用 mmap 实时记录请求保存到文件中，展示的时候从文件中读取数据进行展示？
