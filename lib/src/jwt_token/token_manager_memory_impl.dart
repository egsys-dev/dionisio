import 'package:dionisio/dionisio.dart';

class TokenManagerMemoryImpl implements TokenManager {
  @override
  Future<SessionToken?> sessionToken = Future.value(null);
}
