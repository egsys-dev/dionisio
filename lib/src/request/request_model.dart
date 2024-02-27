import 'package:dionisio/dionisio.dart';

class RequestModel {
  final String endpoint;
  final Method method;
  final dynamic params;
  final dynamic queryParameters;
  final bool tokenEnabled;

  RequestModel({
    required this.endpoint,
    required this.method,
    this.params,
    this.queryParameters,
    this.tokenEnabled = true,
  });

  RequestModel.post({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
  })  : endpoint = endpoint,
        method = Method.POST,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled;

  RequestModel.get({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
  })  : endpoint = endpoint,
        method = Method.GET,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled;

  RequestModel.put({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
  })  : endpoint = endpoint,
        method = Method.PUT,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled;

  RequestModel.delete({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
  })  : endpoint = endpoint,
        method = Method.DELETE,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled;

  RequestModel.patch({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
  })  : endpoint = endpoint,
        method = Method.PATCH,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled;

  RequestModel.head({
    required String endpoint,
    dynamic params,
    dynamic queryParameters,
    bool tokenEnabled = true,
  })  : endpoint = endpoint,
        method = Method.HEAD,
        params = params,
        queryParameters = queryParameters,
        tokenEnabled = tokenEnabled;

  Map<String, dynamic> toMap() {
    return {
      'endpoint': endpoint,
      'method': method.value,
      'params': params,
      'queryParameters': queryParameters,
      'tokenEnabled': tokenEnabled,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      endpoint: map['endpoint'],
      method: Method.values.firstWhere((e) => e.value == map['method']),
      params: map['params'],
      queryParameters: map['queryParameters'],
      tokenEnabled: map['tokenEnabled'],
    );
  }
}
