import 'dart:convert';

class LogoutResponse {
  LogoutResponse({
    this.message,
    this.status,
    this.timestamp,
  });

  String? message;
  String? status;
  DateTime? timestamp;

  factory LogoutResponse.fromRawJson(String str) => LogoutResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
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
