// To parse this JSON data, do
//
//     final feedbackRequest = feedbackRequestFromMap(jsonString);

import 'dart:convert';

class FeedbackRequest {
  FeedbackRequest({
    required this.rating,
    required this.productId,
    required this.customerId,
  });

  double rating;
  int productId;
  int customerId;

  factory FeedbackRequest.fromJson(String str) => FeedbackRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedbackRequest.fromMap(Map<String, dynamic> json) => FeedbackRequest(
    rating: json['rating'],
    productId: json['productId'],
    customerId: json['customerId'],
  );

  Map<String, dynamic> toMap() => {
    'rating': rating,
    'productId': productId,
    'customerId': customerId,
  };
}
