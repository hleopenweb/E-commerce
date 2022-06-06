import 'dart:convert';

class UpdateCartResponse {
  UpdateCartResponse({
    this.message,
    this.status,
    this.timestamp,
  });

  String? message;
  String? status;
  DateTime? timestamp;

  factory UpdateCartResponse.fromRawJson(String str) => UpdateCartResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateCartResponse.fromJson(Map<String, dynamic> json) => UpdateCartResponse(
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
