import 'package:dionisio/dionisio.dart';

class RequestModelRaw {
  final String endpoint;
  final Method method;
  final dynamic params;
  final dynamic queryParameters;
  final Map<String, dynamic>? headers;

  RequestModelRaw({
    required this.endpoint,
    required this.method,
    this.params,
    this.queryParameters,
    this.headers,
  });

  String get methodString {
    switch (method) {
      case Method.POST:
        return "POST";
      case Method.GET:
        return "GET";
      case Method.PUT:
        return "PUT";
      case Method.DELETE:
        return "DELETE";
      case Method.PATCH:
        return "PATCH";
      case Method.HEAD:
        return "HEAD";
      default:
        throw UnimplementedError("Method not found");
    }
  }
}
