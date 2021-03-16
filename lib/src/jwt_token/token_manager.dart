import 'package:dionisio/dionisio.dart';

abstract class TokenManager {
  Future<SessionToken?> getSessionToken();
  Future<void> saveSessionToken(SessionToken? sessionToken);
}
