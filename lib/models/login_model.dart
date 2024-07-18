class LoginResponse {
  final String token;
  final String username;

  LoginResponse({required this.token, required this.username});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      username: json['username'],
    );
  }
}
