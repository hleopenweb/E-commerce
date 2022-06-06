import 'dart:convert';

class PostCommentResponse {
  PostCommentResponse({
    this.message,
    this.status,
    this.timestamp,
  });

  String? message;
  String? status;
  DateTime? timestamp;

  factory PostCommentResponse.fromRawJson(String str) => PostCommentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostCommentResponse.fromJson(Map<String, dynamic> json) => PostCommentResponse(
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
