import 'package:dio/dio.dart';
import 'package:dionisio/dionisio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Reproduz o crash de boot reportado pela Mari: qualquer DioError de
/// nivel de REDE (sem resposta HTTP, error.response == null) nao pode
/// mais estourar `type 'Null' is not a subtype of type 'Map<String, dynamic>'`.
/// Em vez de mockar o DioError (o que exigiria expor o Dio privado de
/// HttpRemoteImpl), este teste forca falhas de rede REAIS: connection
/// refused (porta fechada) e connect timeout (IP nao roteavel, RFC 5737).
class _FakeHttpOptions extends BaseOptions implements HttpOptions {
  _FakeHttpOptions({required String baseUrl, int connectTimeout = 120000})
      : super(baseUrl: baseUrl, connectTimeout: connectTimeout);

  @override
  final bool tokenEnabled = false;
  @override
  final TokenManager? tokenManager = null;
  @override
  final bool? refreshTokenEnabled = false;
  @override
  final String? refreshEndpoint = null;
  @override
  final bool logRequestEnabled = false;
  @override
  Future<Map<String, dynamic>?> get extraHeaders async => null;
  @override
  HttpTransformer<Map<String, dynamic>> get responseTransfomer =>
      (data) => data;

  // Mesmo padrao do HttpOptionsImpl real do syspm-sc-instance-flutter:
  // trata data nulo (erro de rede sem response) como corpo vazio em vez
  // de deixar o cast estourar.
  @override
  HttpTransformerError<Future<Map<String, dynamic>>>
      get responseTransfomerError => (data, statusCode) async {
            return data ?? <String, dynamic>{};
          };
}

void main() {
  test(
    'doRequest nao crasha com connection refused (porta fechada, sem HTTP response)',
    () async {
      final httpOptions = _FakeHttpOptions(baseUrl: 'http://127.0.0.1:1');
      final remote = HttpRemoteImpl(httpOptions: httpOptions);

      final result = await remote.doRequest(
        RequestModel.get(endpoint: '/health'),
      );

      expect(result, equals(<String, dynamic>{}));
    },
  );

  test(
    'doRequestRaw nao crasha com connection refused (porta fechada, sem HTTP response)',
    () async {
      final httpOptions = _FakeHttpOptions(baseUrl: 'http://127.0.0.1:1');
      final remote = HttpRemoteImpl(httpOptions: httpOptions);

      final result = await remote.doRequestRaw(
        RequestModelRaw(endpoint: '/health', method: Method.GET),
      );

      expect(result, equals(<String, dynamic>{}));
    },
  );

  test(
    'doRequest nao crasha com connect timeout (IP nao roteavel, sem HTTP response)',
    () async {
      final httpOptions = _FakeHttpOptions(
        baseUrl: 'http://192.0.2.1',
        connectTimeout: 1000,
      );
      final remote = HttpRemoteImpl(httpOptions: httpOptions);

      final result = await remote.doRequest(
        RequestModel.get(endpoint: '/health'),
      );

      expect(result, equals(<String, dynamic>{}));
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
}
