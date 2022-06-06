// To parse this JSON data, do
//
//     final cartRequest = cartRequestFromJson(jsonString);

import 'dart:convert';

class UpdateCartRequest {
  UpdateCartRequest({
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
  List<UpdateCartItem>? cartItems;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    'modifiedBy': createdBy,
    'customerId': customerId,
    'note': note,
    'totalCost': totalCost,
    'address': address,
    'status': status,
    'paymentMethod': paymentMethod,
    'cartItems': cartItems == null ? null : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
  };
}

class UpdateCartItem {
  UpdateCartItem({
    this.id,
    this.modifiedBy,
    this.productId,
    this.quantity,
    this.salePrice,
  });

  int? id;
  String? modifiedBy;
  int? productId;
  int? quantity;
  int? salePrice;

  factory UpdateCartItem.fromRawJson(String str) => UpdateCartItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateCartItem.fromJson(Map<String, dynamic> json) => UpdateCartItem(
    id: json['id'],
    modifiedBy: json['modifiedBy'],
    productId: json['productId'],
    quantity: json['quantity'],
    salePrice: json['salePrice'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'modifiedBy': modifiedBy,
    'productId': productId,
    'quantity': quantity,
    'salePrice': salePrice,
  };
}
