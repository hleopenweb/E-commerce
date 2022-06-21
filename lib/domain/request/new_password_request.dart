// To parse this JSON data, do
//
//     final cartRequest = cartRequestFromJson(jsonString);

import 'dart:convert';

class NewPasswordRequest {
  NewPasswordRequest({
    this.email,
    this.oldPassword,
    this.password,
  });

  String? email;
  String? oldPassword;
  String? password;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    'email': email,
    'oldPassword': oldPassword,
    'password': password,
  };
}
