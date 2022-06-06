import 'dart:convert';

class CommentResponse {
  CommentResponse({
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

  List<Comments>? content;
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

  factory CommentResponse.fromRawJson(String str) => CommentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentResponse.fromJson(Map<String, dynamic> json) => CommentResponse(
    content: json['content'] == null ? null : List<Comments>.from(json['content'].map((x) => Comments.fromJson(x))),
    pageable: json['pageable'] == null ? null : Pageable.fromJson(json['pageable']),
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
    'content': content == null ? null : List<dynamic>.from(content!.map((x) => x.toJson())),
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

class Comments {
  Comments({
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

  factory Comments.fromRawJson(String str) => Comments.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    id: json['id'],
    createdDate: json['createdDate'] == null ? null : DateTime.parse(json['createdDate']),
    modifiedDate: json['modifiedDate'],
    createdBy: json['createdBy'],
    modifiedBy: json['modifiedBy'],
    comment: json['comment'],
    productId: json['productId'],
    customerId: json['customerId'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdDate': createdDate,
    'modifiedDate': modifiedDate,
    'createdBy': createdBy,
    'modifiedBy': modifiedBy,
    'comment': comment,
    'productId': productId,
    'customerId': customerId,
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

  factory Pageable.fromRawJson(String str) => Pageable.fromJson(json.decode(str));

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
