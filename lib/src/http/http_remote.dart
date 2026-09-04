import 'package:dionisio/dionisio.dart';
import 'dart:typed_data';

abstract class HttpRemote {
  Future<Map<String, dynamic>> doRequest(RequestModel request);
  Future<Map<String, dynamic>> doRequestRaw(RequestModelRaw request);
  Future<Uint8List> doRequestBytes(String url);
}
