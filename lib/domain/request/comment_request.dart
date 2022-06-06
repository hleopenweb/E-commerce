import 'dart:convert';

class CommentRequest {
  CommentRequest({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.comment,
    this.productId,
    this.customerId,
  });

  int? id;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? createdBy;
  String? modifiedBy;
  String? comment;
  int? productId;
  int? customerId;

  factory CommentRequest.fromRawJson(String str) => CommentRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentRequest.fromJson(Map<String, dynamic> json) => CommentRequest(
    id: json['id'],
    createdDate: json['createdDate'] == null ? null : DateTime.parse(json['createdDate']),
    modifiedDate: json['modifiedDate'] == null ? null : DateTime.parse(json['modifiedDate']),
    createdBy: json['createdBy'],
    modifiedBy: json['modifiedBy'],
    comment: json['comment'],
    productId: json['productId'],
    customerId: json['customerId'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdDate': createdDate ,
    'modifiedDate': modifiedDate ,
    'createdBy': createdBy,
    'modifiedBy': modifiedBy,
    'comment': comment,
    'productId': productId,
    'customerId': customerId,
  };
}
