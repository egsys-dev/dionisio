import 'package:dio/dio.dart';
import 'package:dionisio/dionisio.dart';

abstract class HttpOptions implements BaseOptions {
  bool get tokenEnabled;
  TokenManager? get tokenManager;
  bool? get refreshTokenEnabled;
  String? get refreshEndpoint;
  bool get logRequestEnabled => false;
  Future<Map<String, dynamic>?> get extraHeaders;
  HttpTransformer<Map<String, dynamic>> get responseTransfomer;
  HttpTransformerError<Future<Map<String, dynamic>>>
      get responseTransfomerError;
}
