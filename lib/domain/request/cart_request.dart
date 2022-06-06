// To parse this JSON data, do
//
//     final cartRequest = cartRequestFromJson(jsonString);

import 'dart:convert';

class CartRequest {
  CartRequest({
    this.id,
    this.createdBy,
    this.customerId,
    this.note,
    this.totalCost,
    this.address,
    this.status,
    this.paymentMethod,
    this.cartItems,
  });

  int? id ;
  String? createdBy;
  int? customerId;
  String? note;
  int? totalCost;
  String? address;
  String? status;
  String? paymentMethod;
  List<CartItem>? cartItems;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    'createdBy': createdBy,
    'customerId': customerId,
    'note': note,
    'totalCost': totalCost,
    'address': address,
    'status': status,
    'paymentMethod': paymentMethod,
    'cartItems': cartItems == null ? null : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
  };
}

class CartItem {
  CartItem({
    this.id,
    this.createdBy,
    this.productId,
    this.quantity,
    this.salePrice,
  });

  int? id;
  String? createdBy;
  int? productId;
  int? quantity;
  int? salePrice;

  factory CartItem.fromRawJson(String str) => CartItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['id'],
    createdBy: json['createdBy'],
    productId: json['productId'],
    quantity: json['quantity'],
    salePrice: json['salePrice'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdBy': createdBy,
    'productId': productId,
    'quantity': quantity,
    'salePrice': salePrice,
  };
}
