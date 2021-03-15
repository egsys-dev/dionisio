import 'package:dio/dio.dart';
import 'package:dionisio/dionisio.dart';

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
    if (!_httpDio.interceptors.contains(_onRequest) && request.tokenEnabled) {
      _httpDio.interceptors.add(
        InterceptorsWrapper(
          onRequest: _onRequest,
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
          method: request.methodString,
          sendTimeout: _httpDio.options.sendTimeout,
        ),
      );

      DateTime requestDone = DateTime.now();

      final requestTime = requestDone.difference(requestInit).inMilliseconds;

      if (_httpOptions.logRequestEnabled) {
        print('ENDPOINT => ${request.endpoint}\n'
            'METHOD => ${request.methodString}\n'
            'STATUS => ${response.data['status']}\n'
            'TIME => $requestTime');
      }

      final data = response.data as Map<String, dynamic>;
      return _httpOptions.responseTransfomer(data);
    } on DioError catch (error, _) {
      if (_isErroInesperado(error)) {
        rethrow;
      }

      return error.response?.data as Map<String, dynamic>;
    }
  }

  dynamic Function(RequestOptions) get _onRequest =>
      (RequestOptions requestOptions) async {
        /// Se o token não estiver habilitado, apenas retorna
        if (!_httpOptions.tokenEnabled) {
          return;
        }

        final tokenManager = _httpOptions.tokenManager;
        if (tokenManager == null) {
          throw UnimplementedError(
              'Token ativo, porém TokenManager não definido');
        }

        var sessionToken = await tokenManager.sessionToken;
        final tokenExpired = sessionToken?.tokenExpired ?? true;

        if (tokenExpired) {
          /// Tratativa para refresg token
        }

        if (sessionToken == null) {
          throw UnimplementedError('Não foi possível resolver o SessionToken');
        }

        requestOptions.headers["Authorization"] =
            "Bearer ${sessionToken.token}";
      };

  /// Verifica se o erro que veio da API é um erro não tratado.
  bool _isErroInesperado(DioError error) {
    return (error.type != DioErrorType.response &&
            error.type != DioErrorType.cancel) ||
        error.response?.statusCode == 500;
  }
}
