import 'package:dionisio/dionisio.dart';

class TokenManagerMemoryImpl implements TokenManager {
  SessionToken? _sessionToken;

  @override
  Future<SessionToken?> getSessionToken() => Future.value(_sessionToken);

  @override
  Future<void> saveSessionToken(SessionToken? sessionToken) async {
    _sessionToken = sessionToken;
  }
}
