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

  Map<String, dynamic> toMap() {
    return {
      'endpoint': endpoint,
      'method': method.value,
      'params': params,
      'queryParameters': queryParameters,
      'headers': headers,
    };
  }

  factory RequestModelRaw.fromMap(Map<String, dynamic> map) {
    return RequestModelRaw(
      endpoint: map['endpoint'] ?? '',
      method: Method.values.firstWhere((e) => e.value == map['method']),
      params: map['params'] ?? null,
      queryParameters: map['queryParameters'] ?? null,
      headers: map['headers'] != null
          ? Map<String, dynamic>.from(map['headers'])
          : null,
    );
  }
}
