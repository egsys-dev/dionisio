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
    return DateTime.now().difference(tokenDate!).inMinutes > tokenTimeoutInMinutes!;
  }
}
