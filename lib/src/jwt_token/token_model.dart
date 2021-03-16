import 'dart:convert';

class SessionToken {
  final String? token;
  final String? refreshToken;
  final DateTime? tokenDate;
  final int? tokenTimeoutInMinutes;

  SessionToken({
    this.token,
    this.refreshToken,
    this.tokenDate,
    this.tokenTimeoutInMinutes,
  });

  SessionToken copyWith({
    String? token,
    String? refreshToken,
    DateTime? tokenDate,
    int? tokenTimeout,
  }) {
    return SessionToken(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      tokenDate: tokenDate ?? this.tokenDate,
      tokenTimeoutInMinutes: tokenTimeout ?? this.tokenTimeoutInMinutes,
    );
  }

  bool get tokenExpired {
    if (token == null) return false;
    if (tokenTimeoutInMinutes == null) return false;
    if (tokenDate == null) return false;
    return DateTime.now().difference(tokenDate!).inMinutes >
        tokenTimeoutInMinutes!;
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'tokenDate': tokenDate?.toIso8601String(),
      'tokenTimeoutInMinutes': tokenTimeoutInMinutes,
    };
  }

  factory SessionToken.fromMap(Map<String, dynamic> map) {
    return SessionToken(
      token: map['token'] as String?,
      refreshToken: map['refreshToken'] as String?,
      tokenDate: DateTime.tryParse(map['tokenDate']),
      tokenTimeoutInMinutes: map['tokenTimeoutInMinutes'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionToken.fromJson(String source) =>
      SessionToken.fromMap(json.decode(source));
}
