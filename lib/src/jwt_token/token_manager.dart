import 'package:dionisio/dionisio.dart';

abstract class TokenManager {
  Future<SessionToken?> get sessionToken;
  set sessionToken(Future<SessionToken?> sessionToken);
}
