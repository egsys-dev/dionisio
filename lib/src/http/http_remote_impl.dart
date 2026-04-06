import 'package:flutter/foundation.dart';
import 'package:dionisio/dionisio.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class HttpRemoteImpl implements HttpRemote {
  final HttpOptions _httpOptions;
  Dio _httpDio = Dio();

  HttpRemoteImpl({
    required HttpOptions httpOptions,
  }) : _httpOptions = httpOptions {
    _httpDio.options = _httpOptions;
  }

  @override
  Future<Map<String, dynamic>> doRequest(RequestModel request) async {
    if (!_httpDio.interceptors.contains(_onRequest)) {
      _httpDio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (requestOptions) => _onRequest(
            requestOptions,
            request,
          ),
        ),
      );
    }

    try {
      DateTime requestInit = DateTime.now();

      Response<dynamic> response = await _httpDio.request<dynamic>(
        request.endpoint,
        data: request.params,
        queryParameters: request.queryParameters,
        options: Options(
          method: request.method.value,
          sendTimeout: _httpDio.options.sendTimeout,
          contentType: request.contentType,
        ),
      );

      DateTime requestDone = DateTime.now();

      final requestTime = requestDone.difference(requestInit).inMilliseconds;

      if (_httpOptions.logRequestEnabled) {
        print(
          'ENDPOINT => ${request.endpoint}\n'
          'METHOD => ${request.method.value}\n'
          'STATUS => ${response.data['status']}\n'
          'TIME => $requestTime',
        );
      }

      final data = response.data as Map<String, dynamic>;
      return _httpOptions.responseTransfomer(data);
    } on DioError catch (error, _) {
      if (_isErroInesperado(error)) {
        if (kDebugMode) {
          log(error.message);
          log(error.response?.toString() ?? '');
        }

        rethrow;
      }

      return _httpOptions.responseTransfomerError(
        error.response?.data as Map<String, dynamic>,
        error.response?.statusCode,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> doRequestRaw(RequestModelRaw request) async {
    try {
      DateTime requestInit = DateTime.now();

      Response<dynamic> response = await _httpDio.request<dynamic>(
        request.endpoint,
        data: request.params,
        queryParameters: request.queryParameters,
        options: Options(
          method: request.method.value,
          sendTimeout: _httpDio.options.sendTimeout,
          headers: request.headers,
        ),
      );

      DateTime requestDone = DateTime.now();

      final requestTime = requestDone.difference(requestInit).inMilliseconds;

      if (_httpOptions.logRequestEnabled) {
        print(
          'ENDPOINT => ${request.endpoint}\n'
          'METHOD => ${request.method.value}\n'
          'STATUS => ${response.data['status']}\n'
          'TIME => $requestTime',
        );
      }

      final data = response.data as Map<String, dynamic>;
      return _httpOptions.responseTransfomer(data);
    } on DioError catch (error, _) {
      if (_isErroInesperado(error)) {
        if (kDebugMode) {
          log(error.message);
          log(error.response?.toString() ?? '');
        }

        rethrow;
      }

      return _httpOptions.responseTransfomerError(
        error.response?.data as Map<String, dynamic>,
        error.response?.statusCode,
      );
    }
  }

  dynamic Function(RequestOptions, RequestModel) get _onRequest =>
      (RequestOptions requestOptions, RequestModel request) async {
        final headers = request.headers;
        if (headers != null) {
          requestOptions.headers.addAll(headers);
        }

        final extraHeaders = await _httpOptions.extraHeaders;
        if (extraHeaders != null && request.extraHeadersEnabled) {
          requestOptions.headers.addAll(extraHeaders);
        }

        /// Se o token não estiver habilitado, apenas retorna
        if (!_httpOptions.tokenEnabled) return;

        final tokenManager = _httpOptions.tokenManager;
        if (tokenManager == null) {
          throw UnimplementedError(
            'Token ativo, porém TokenManager não definido',
          );
        }

        var sessionToken = await tokenManager.getSessionToken();
        if (sessionToken == null) return;

        final authorization = {"Authorization": "Bearer ${sessionToken.token}"};
        requestOptions.headers.addAll(authorization);

        return;
      };

  /// Verifica se o erro que veio da API é um erro não tratado.
  bool _isErroInesperado(DioError error) {
    return (error.type != DioErrorType.response &&
            error.type != DioErrorType.cancel) ||
        error.response?.statusCode == 500;
  }
}
