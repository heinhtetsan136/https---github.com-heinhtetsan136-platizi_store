class Token {
  final String acesstoken;
  final String refreshtoken;

  Token({required this.acesstoken, required this.refreshtoken});
  factory Token.fromJson(dynamic data) {
    return Token(
        acesstoken: data["access_token"], refreshtoken: data["refresh_token"]);
  }
}
