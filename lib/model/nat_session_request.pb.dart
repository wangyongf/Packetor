///
//  Generated code. Do not modify.
//  source: android/app/src/main/proto/nat_session_request.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, Map, override;

import 'package:protobuf/protobuf.dart' as $pb;

class NatSessionRequests extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('NatSessionRequests', package: const $pb.PackageName('com.yongf.flutter.packetcaptureflutter.model'))
    ..pc<NatSessionRequest>(1, 'request', $pb.PbFieldType.PM,NatSessionRequest.create)
    ..hasRequiredFields = false
  ;

  NatSessionRequests() : super();
  NatSessionRequests.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NatSessionRequests.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NatSessionRequests clone() => new NatSessionRequests()..mergeFromMessage(this);
  NatSessionRequests copyWith(void Function(NatSessionRequests) updates) => super.copyWith((message) => updates(message as NatSessionRequests));
  $pb.BuilderInfo get info_ => _i;
  static NatSessionRequests create() => new NatSessionRequests();
  NatSessionRequests createEmptyInstance() => create();
  static $pb.PbList<NatSessionRequests> createRepeated() => new $pb.PbList<NatSessionRequests>();
  static NatSessionRequests getDefault() => _defaultInstance ??= create()..freeze();
  static NatSessionRequests _defaultInstance;

  List<NatSessionRequest> get request => $_getList(0);
}

class NatSessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('NatSessionRequest', package: const $pb.PackageName('com.yongf.flutter.packetcaptureflutter.model'))
    ..aOB(1, 'isRequest')
    ..aOS(2, 'headStr')
    ..aOS(3, 'bodyStr')
    ..a<List<int>>(4, 'bodyImage', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  NatSessionRequest() : super();
  NatSessionRequest.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NatSessionRequest.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NatSessionRequest clone() => new NatSessionRequest()..mergeFromMessage(this);
  NatSessionRequest copyWith(void Function(NatSessionRequest) updates) => super.copyWith((message) => updates(message as NatSessionRequest));
  $pb.BuilderInfo get info_ => _i;
  static NatSessionRequest create() => new NatSessionRequest();
  NatSessionRequest createEmptyInstance() => create();
  static $pb.PbList<NatSessionRequest> createRepeated() => new $pb.PbList<NatSessionRequest>();
  static NatSessionRequest getDefault() => _defaultInstance ??= create()..freeze();
  static NatSessionRequest _defaultInstance;

  bool get isRequest => $_get(0, false);
  set isRequest(bool v) { $_setBool(0, v); }
  bool hasIsRequest() => $_has(0);
  void clearIsRequest() => clearField(1);

  String get headStr => $_getS(1, '');
  set headStr(String v) { $_setString(1, v); }
  bool hasHeadStr() => $_has(1);
  void clearHeadStr() => clearField(2);

  String get bodyStr => $_getS(2, '');
  set bodyStr(String v) { $_setString(2, v); }
  bool hasBodyStr() => $_has(2);
  void clearBodyStr() => clearField(3);

  List<int> get bodyImage => $_getN(3);
  set bodyImage(List<int> v) { $_setBytes(3, v); }
  bool hasBodyImage() => $_has(3);
  void clearBodyImage() => clearField(4);
}

