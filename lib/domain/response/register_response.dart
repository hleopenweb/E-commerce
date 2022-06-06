import 'dart:convert';

class RegisterResponse {
  RegisterResponse({
    this.message,
    this.status,
    this.timestamp,
  });

  String? message;
  String? status;
  DateTime? timestamp;

  factory RegisterResponse.fromRawJson(String str) => RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    message: json['message'],
    status: json['status'],
    timestamp: json['timestamp'] == null ? null : DateTime.parse(json['timestamp']),
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'timestamp': timestamp,
  };
}
