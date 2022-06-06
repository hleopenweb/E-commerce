// To parse this JSON data, do
//
//     final addOrderRequest = addOrderRequestFromJson(jsonString);

import 'dart:convert';

class AddOrderRequest {
  AddOrderRequest({
    this.customerId,
    this.note,
    this.totalCost,
    this.address,
    this.status,
    this.paymentMethod,
  });

  int? customerId;
  String? note;
  int? totalCost;
  String? address;
  String? status;
  String? paymentMethod;

  factory AddOrderRequest.fromRawJson(String str) => AddOrderRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddOrderRequest.fromJson(Map<String, dynamic> json) => AddOrderRequest(
    customerId: json['customerId'],
    note: json['note'],
    totalCost: json['totalCost'],
    address: json['address'],
    status: json['status'],
    paymentMethod: json['paymentMethod'],
  );

  Map<String, dynamic> toJson() => {
    'customerId': customerId,
    'note': note,
    'totalCost': totalCost,
    'address': address,
    'status': status,
    'paymentMethod': paymentMethod,
  };
}
