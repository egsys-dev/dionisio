import 'package:dionisio/dionisio.dart';

abstract class HttpRemote {
  Future<Map<String, dynamic>> doRequest(RequestModel request);
  Future<Map<String, dynamic>> doRequestRaw(RequestModelRaw request);
}
