/// 一个简单的 Http 请求解析工具，一期考虑可用，二期再优化
class HttpRequest {
  final String _request;
  String _method;
  String _path;
  String _httpVersion;
  Map<String, String> _queryParameters;
  Map<String, String> _headers;

  static const String EMPTY = " ";
  static const int INDEX_404 = -1;

  static const String GET = "GET";
  static const String POST = "POST";
  static const String OPTION = "OPTION";
  static const String DELETE = "DELETE";

  HttpRequest(this._request);

  static parse(String request) {
    if (request == null) {
      request = "";
    }
    return HttpRequest(request);
  }

  void parseInternal() {
    List<String> list = _request.split("\n");
    if (list == null || list.isEmpty) {
      return;
    }
    String requestLine = list[0];
    parseRequestLine(requestLine);
    _parseRequestHeaders(list);
  }

  void parseRequestLine(String requestLine) {
    if (requestLine == null || requestLine.isEmpty) {
      _method = "";
      _path = "";
      _httpVersion = "";
      _queryParameters = Map();
      _headers = Map();
      return;
    }
    List<String> requestLineList = requestLine.split(EMPTY);
    if (requestLineList != null && requestLineList.length == 3) {
      _method = requestLineList[0];
      _path = requestLineList[1];
      _httpVersion = requestLine[2];
      parseQueryParameters(_path);
    }
  }

  void parseQueryParameters(String path) {
    if (path == null || path.isEmpty) {
      path = "";
      return;
    }
    var uri = Uri.parse(path);
    _queryParameters = uri.queryParameters;
  }

  void _parseRequestHeaders(List<String> list) {
    if (list == null || list.length < 2) {
      return;
    }
    var tempHeaders = Map<String, String>();
    list.asMap()?.forEach((index, header) {
      if (index == 0 || header == null || header.isEmpty) {
        return;
      }
      var position = _parseSingleHeader(header);
      if (INDEX_404 != position) {
        var key = header.substring(0, position) ?? "";
        var value = header.substring(position + 1) ?? "";
        tempHeaders[key.trim()] = value.trim();
      }
    });
    _headers = tempHeaders;
  }

  /// 用于获取单一请求行中分隔符的位置
  int _parseSingleHeader(String header) {
    for (int i = 0; i < header.length; i++) {
      if (header[i] == ':') {
        return i;
      }
    }
    return INDEX_404;
  }

  String getMethod() {
    if (_method != null) {
      return _method;
    }
    parseInternal();
    return _method;
  }

  String getPath() {
    if (_path != null) {
      return _path;
    }
    parseInternal();
    return _path;
  }

  String getHttpVersion() {
    if (_httpVersion != null) {
      return _httpVersion;
    }
    parseInternal();
    return _httpVersion;
  }

  Map<String, String> getQueryParameters() {
    if (_queryParameters != null) {
      return _queryParameters;
    }
    parseInternal();
    return _queryParameters;
  }

  String getQueryParameter(String key) {
    if (_queryParameters != null) {
      return _queryParameters[key];
    }
    parseInternal();
    if (_queryParameters != null) {
      return _queryParameters[key];
    }
    return "";
  }

  Map<String, String> getHeaders() {
    if (_headers != null) {
      return _headers;
    }
    parseInternal();
    return _headers;
  }

  String getHeader(String key) {
    if (_headers != null) {
      return _headers[key];
    }
    parseInternal();
    if (_headers != null) {
      return _headers[key];
    }
    return "";
  }
}
