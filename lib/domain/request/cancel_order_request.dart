
import 'dart:convert';

class CancelOrderRequest {
  CancelOrderRequest({
    required this.userId,
    required this.status,
  });

  int userId;
  String status;

  factory CancelOrderRequest.fromJson(String str) => CancelOrderRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CancelOrderRequest.fromMap(Map<String, dynamic> json) => CancelOrderRequest(
    userId: json['userId'],
    status: json['status'],
  );

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'status': status,
  };
}
