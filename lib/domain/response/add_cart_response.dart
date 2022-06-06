import 'dart:convert';

class AddCartResponse {
  AddCartResponse({
    this.message,
    this.status,
    this.timestamp,
  });

  String? message;
  String? status;
  DateTime? timestamp;

  factory AddCartResponse.fromRawJson(String str) => AddCartResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddCartResponse.fromJson(Map<String, dynamic> json) => AddCartResponse(
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
