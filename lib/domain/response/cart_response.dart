// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

class CartResponse {
  CartResponse({
    this.content,
    this.pageable,
    this.totalPages,
    this.totalElements,
    this.last,
    this.first,
    this.sort,
    this.numberOfElements,
    this.size,
    this.number,
    this.empty,
  });

  List<ContentCart>? content;
  Pageable? pageable;
  int? totalPages;
  int? totalElements;
  bool? last;
  bool? first;
  Sort? sort;
  int? numberOfElements;
  int? size;
  int? number;
  bool? empty;

  factory CartResponse.fromRawJson(String str) =>
      CartResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        content: json['content'] == null
            ? null
            : List<ContentCart>.from(
                json['content'].map((x) => ContentCart.fromJson(x))),
        pageable: json['pageable'] == null
            ? null
            : Pageable.fromJson(json['pageable']),
        totalPages: json['totalPages'],
        totalElements: json['totalElements'],
        last: json['last'],
        first: json['first'],
        sort: json['sort'] == null ? null : Sort.fromJson(json['sort']),
        numberOfElements: json['numberOfElements'],
        size: json['size'],
        number: json['number'],
        empty: json['empty'],
      );

  Map<String, dynamic> toJson() => {
        'content': content == null
            ? null
            : List<dynamic>.from(content!.map((x) => x.toJson())),
        'pageable': pageable?.toJson(),
        'totalPages': totalPages,
        'totalElements': totalElements,
        'last': last,
        'first': first,
        'sort': sort?.toJson(),
        'numberOfElements': numberOfElements,
        'size': size,
        'number': number,
        'empty': empty,
      };
}

class ContentCart {
  ContentCart({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.quantity,
    this.salePrice,
    this.customerId,
    this.productId,
    this.productName,
    this.productThumbnail,
    required this.isCheck,
  });

  int? id;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? createdBy;
  String? modifiedBy;
  int? quantity;
  double? salePrice;
  int? customerId;
  int? productId;
  String? productName;
  String? productThumbnail;
  RxBool isCheck ;

  factory ContentCart.fromRawJson(String str) =>
      ContentCart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContentCart.fromJson(Map<String, dynamic> json) => ContentCart(
        id: json['id'],
        createdDate: json['createdDate'] == null
            ? null
            : DateTime.parse(json['createdDate']),
        modifiedDate: json['modifiedDate'] == null
            ? null
            : DateTime.parse(json['modifiedDate']),
        createdBy: json['createdBy'],
        modifiedBy: json['modifiedBy'],
        quantity: json['quantity'],
        salePrice: json['salePrice'],
        customerId: json['customerId'],
        productId: json['productId'],
        productName: json['productName'],
        productThumbnail: json['productThumbnail'], isCheck: false.obs,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdDate': createdDate,
        'modifiedDate': modifiedDate,
        'createdBy': createdBy,
        'modifiedBy': modifiedBy,
        'quantity': quantity,
        'salePrice': salePrice,
        'customerId': customerId,
        'productId': productId,
      };
}

class Pageable {
  Pageable({
    this.sort,
    this.pageNumber,
    this.pageSize,
    this.offset,
    this.paged,
    this.unpaged,
  });

  Sort? sort;
  int? pageNumber;
  int? pageSize;
  int? offset;
  bool? paged;
  bool? unpaged;

  factory Pageable.fromRawJson(String str) =>
      Pageable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: json['sort'] == null ? null : Sort.fromJson(json['sort']),
        pageNumber: json['pageNumber'],
        pageSize: json['pageSize'],
        offset: json['offset'],
        paged: json['paged'],
        unpaged: json['unpaged'],
      );

  Map<String, dynamic> toJson() => {
        'sort': sort?.toJson(),
        'pageNumber': pageNumber,
        'pageSize': pageSize,
        'offset': offset,
        'paged': paged,
        'unpaged': unpaged,
      };
}

class Sort {
  Sort({
    this.sorted,
    this.unsorted,
    this.empty,
  });

  bool? sorted;
  bool? unsorted;
  bool? empty;

  factory Sort.fromRawJson(String str) => Sort.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json['sorted'],
        unsorted: json['unsorted'],
        empty: json['empty'],
      );

  Map<String, dynamic> toJson() => {
        'sorted': sorted,
        'unsorted': unsorted,
        'empty': empty,
      };
}
