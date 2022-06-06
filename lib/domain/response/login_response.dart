import 'dart:convert';

class LoginResponse {
  LoginResponse({
    this.token,
    this.refreshToken,
    this.type,
    this.id,
    this.username,
    this.email,
    this.roles,
  });

  factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String? token;
  String? refreshToken;
  String? type;
  int? id;
  String? username;
  String? email;
  List<String>? roles;

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    token: json['token'],
    refreshToken: json['refreshToken'],
    type: json['type'],
    id: json['id'],
    username: json['username'],
    email: json['email'],
    roles: json['roles'] == null ? null : List<String>.from(json['roles'].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    'token': token,
    'type': type,
    'id': id,
    'username': username,
    'email': email,
    'roles': roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
  };
}
