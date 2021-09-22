class Token {
  Token({
    required this.token,
  });

  String token;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
