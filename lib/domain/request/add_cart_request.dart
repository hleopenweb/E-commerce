// To parse this JSON data, do
//
//     final cartRequest = cartRequestFromJson(jsonString);

import 'dart:convert';

class AddCartRequest {
  AddCartRequest({
    this.customerId,
    this.productId,
    this.quantity,
    this.salePrice,
  });

  int? customerId;
  int? productId;
  int? quantity;
  int? salePrice;

  factory AddCartRequest.fromRawJson(String str) => AddCartRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddCartRequest.fromJson(Map<String, dynamic> json) => AddCartRequest(
    customerId: json['customerId'],
    productId: json['productId'],
    quantity: json['quantity'],
    salePrice: json['salePrice'],
  );

  Map<String, dynamic> toJson() => {
    'customerId': customerId,
    'productId': productId,
    'quantity': quantity,
    'salePrice': salePrice,
  };
}
