// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

class Product {
  Product({
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

  List<Content>? content;
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

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
        content: json['content'] == null
            ? null
            : List<Content>.from(
            json['content'].map((x) => Content.fromJson(x))),
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

  Map<String, dynamic> toJson() =>
      {
        'content': content == null
            ? null
            : List<dynamic>.from(content!.map((x) => x.toJson())),
        'pageable': pageable == null ? null : pageable!.toJson(),
        'totalPages': totalPages,
        'totalElements': totalElements,
        'last': last,
        'first': first,
        'sort': sort == null ? null : sort!.toJson(),
        'numberOfElements': numberOfElements,
        'size': size,
        'number': number,
        'empty': empty,
      };
}

class Content {
  Content({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.name,
    this.brand,
    this.shortDescription,
    this.description,
    this.price,
    this.unitInStock,
    this.thumbnail,
    this.categoryId,
    this.discount,
    this.ratingAverage,
    this.isCheck,
  });

  int? id;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? createdBy;
  String? modifiedBy;
  String? name;
  String? brand;
  String? shortDescription;
  String? description;
  double? price;
  int? unitInStock;
  String? thumbnail;
  int? discount;
  double? ratingAverage;
  int? categoryId;
  bool? isCheck;

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) =>
      Content(
        id: json['id'],
        createdDate: json['createdDate'] == null
            ? null
            : DateTime.parse(json['createdDate']),
        modifiedDate: json['modifiedDate'] == null
            ? null
            : DateTime.parse(json['modifiedDate']),
        createdBy: json['createdBy'],
        modifiedBy: json['modifiedBy'],
        name: json['name'],
        brand: json['brand'],
        shortDescription: json['shortDescription'],
        description: json['description'],
        price: json['price'],
        unitInStock: json['unitInStock'],
        discount: json['discount'],
        ratingAverage: json['ratingAverage'] ?? 0.0 ,
        thumbnail: json['thumbnail'],
        categoryId: json['categoryId'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'createdDate': createdDate,
        'modifiedDate': modifiedDate,
        'createdBy': createdBy,
        'modifiedBy': modifiedBy,
        'name': name,
        'brand': brand,
        'shortDescription': shortDescription,
        'description': description,
        'price': price,
        'unitInStock': unitInStock,
        'thumbnail': thumbnail,
        'categoryId': categoryId
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

  factory Pageable.fromJson(Map<String, dynamic> json) =>
      Pageable(
        sort: json['sort'] == null ? null : Sort.fromJson(json['sort']),
        pageNumber: json['pageNumber'],
        pageSize: json['pageSize'],
        offset: json['offset'],
        paged: json['paged'],
        unpaged: json['unpaged'],
      );

  Map<String, dynamic> toJson() =>
      {
        'sort': sort == null ? null : sort!.toJson(),
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

  factory Sort.fromJson(Map<String, dynamic> json) =>
      Sort(
        sorted: json['sorted'],
        unsorted: json['unsorted'],
        empty: json['empty'],
      );

  Map<String, dynamic> toJson() =>
      {
        'sorted': sorted,
        'unsorted': unsorted,
        'empty': empty,
      };
}
