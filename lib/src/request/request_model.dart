import 'package:dionisio/dionisio.dart';

class RequestModel {
  final String endpoint;
  final Method method;
  final dynamic params;
  final dynamic queryParameters;
  final bool tokenEnabled;
  final String? contentType;

  RequestModel({
    required this.endpoint,
    required this.method,
    this.params,
    this.queryParameters,
    this.tokenEnabled = true,
    this.contentType,
  });

  RequestModel.post({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
    String? contentType,
  })  : endpoint = endpoint,
        method = Method.POST,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled,
        contentType = contentType;

  RequestModel.get({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
    String? contentType,
  })  : endpoint = endpoint,
        method = Method.GET,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled,
        contentType = contentType;

  RequestModel.put({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
    String? contentType,
  })  : endpoint = endpoint,
        method = Method.PUT,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled,
        contentType = contentType;

  RequestModel.delete({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
    String? contentType,
  })  : endpoint = endpoint,
        method = Method.DELETE,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled,
        contentType = contentType;

  RequestModel.patch({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
    String? contentType,
  })  : endpoint = endpoint,
        method = Method.PATCH,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled,
        contentType = contentType;

  RequestModel.head({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
    String? contentType,
  })  : endpoint = endpoint,
        method = Method.HEAD,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled,
        contentType = contentType;

  Map<String, dynamic> toMap() {
    return {
      'endpoint': endpoint,
      'method': method.value,
      'params': params,
      'queryParameters': queryParameters,
      'tokenEnabled': tokenEnabled,
      'contentType': contentType,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      endpoint: map['endpoint'],
      method: Method.values.firstWhere((e) => e.value == map['method']),
      params: map['params'],
      queryParameters: map['queryParameters'],
      tokenEnabled: map['tokenEnabled'],
      contentType: map['contentType'],
    );
  }
}
