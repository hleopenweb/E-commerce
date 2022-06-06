// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

class OrderResponse {
  OrderResponse({
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

  List<OrderContent>? content;
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

  factory OrderResponse.fromRawJson(String str) =>
      OrderResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        content: List<OrderContent>.from(
            json['content'].map((x) => OrderContent.fromJson(x))),
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
            ? []
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

class OrderContent {
  OrderContent({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.note,
    this.totalCost,
    this.address,
    this.status,
    this.paymentMethod,
    this.customerName,
    this.cartItems,
    this.customerId,
    required this.isExpanded,
  });

  int? id;
  DateTime? createdDate;
  DateTime? modifiedDate;
  EdBy? createdBy;
  EdBy? modifiedBy;
  String? note;
  double? totalCost;
  String? address;
  String? status;
  PaymentMethod? paymentMethod;
  String? customerName;
  List<OrderItem>? cartItems;
  int? customerId;
  RxBool isExpanded;

  factory OrderContent.fromRawJson(String str) =>
      OrderContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderContent.fromJson(Map<String, dynamic> json) => OrderContent(
        id: json['id'],
        createdDate: json['createdDate'] == null
            ? null
            : DateTime.parse(json['createdDate']),
        modifiedDate: json['modifiedDate'] == null
            ? null
            : DateTime.parse(json['modifiedDate']),
        createdBy: json['createdBy'] == null
            ? null
            : edByValues.map![json['createdBy']],
        modifiedBy: json['modifiedBy'] == null
            ? null
            : edByValues.map![json['modifiedBy']],
        note: json['note'],
        totalCost: json['totalCost'],
        address: json['address'],
        status: json['status'],
        paymentMethod: json['paymentMethod'] == null
            ? null
            : paymentMethodValues.map![json['paymentMethod']],
        customerName: json['customerName'],
        cartItems: json['cartItems'] == null
            ? null
            : List<OrderItem>.from(
                json['cartItems'].map((x) => OrderItem.fromJson(x))),
        customerId: json['customerId'],
        isExpanded: false.obs,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdDate': createdDate == null ? null : createdDate.toString(),
        'modifiedDate': modifiedDate == null ? null : modifiedDate.toString(),
        'createdBy': createdBy == null ? null : edByValues.reverse[createdBy],
        'modifiedBy':
            modifiedBy == null ? null : edByValues.reverse[modifiedBy],
        'note': note,
        'totalCost': totalCost,
        'address': address,
        'status': status,
        'paymentMethod': paymentMethod == null
            ? null
            : paymentMethodValues.reverse[paymentMethod],
        'customerName': customerName,
        'cartItems': cartItems == null
            ? null
            : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
        'customerId': customerId,
      };
}

class OrderItem {
  OrderItem({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.quantity,
    this.salePrice,
    this.cartId,
    this.productId,
    this.productName,
    this.productThumbnail,
  });

  int? id;
  DateTime? createdDate;
  DateTime? modifiedDate;
  EdBy? createdBy;
  EdBy? modifiedBy;
  int? quantity;
  double? salePrice;
  int? cartId;
  int? productId;
  String? productName;
  String? productThumbnail;

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['id'],
        createdDate: json['createdDate'] == null
            ? null
            : DateTime.parse(json['createdDate']),
        modifiedDate: json['modifiedDate'],
        createdBy: json['createdBy'] == null
            ? null
            : edByValues.map![json['createdBy']],
        modifiedBy: json['modifiedBy'],
        quantity: json['quantity'],
        salePrice: json['salePrice'],
        cartId: json['cartId'],
        productId: json['productId'],
        productName: json['productName'],
        productThumbnail: json['productThumbnail'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdDate': createdDate == null ? null : createdDate.toString(),
        'modifiedDate': modifiedDate,
        'createdBy': createdBy == null ? null : edByValues.reverse[createdBy],
        'modifiedBy': modifiedBy,
        'quantity': quantity,
        'salePrice': salePrice,
        'cartId': cartId,
        'productId': productId,
        'productName': productName,
        'productThumbnail': productThumbnail,
      };
}

enum EdBy { ADMIN01, CUSTOMER01 }

final edByValues =
    EnumValues({'admin01': EdBy.ADMIN01, 'customer01': EdBy.CUSTOMER01});

enum PaymentMethod { CASH, PAYPAL }

final paymentMethodValues =
    EnumValues({'CASH': PaymentMethod.CASH, 'PAYPAL': PaymentMethod.PAYPAL});

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
        'sort': sort == null ? null : sort?.toJson(),
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

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map?.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
