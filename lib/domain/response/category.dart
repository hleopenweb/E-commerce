
import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.name,
    this.description,
    this.thumbnail,
  });

  int? id;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? createdBy;
  String? modifiedBy;
  String? name;
  String? description;
  String? thumbnail;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    createdDate: json['createdDate'] == null ? null : DateTime.parse(json['createdDate']),
    modifiedDate: json['modifiedDate'] == null ? null : DateTime.parse(json['modifiedDate']),
    createdBy: json['createdBy'],
    modifiedBy: json['modifiedBy'],
    name: json['name'],
    description: json['description'],
    thumbnail: json['thumbnail'],
  );

  Map<String, dynamic> toJson() => {
    'id': id ,
    'createdDate': createdDate ,
    'modifiedDate': modifiedDate,
    'createdBy': createdBy,
    'modifiedBy': modifiedBy,
    'name': name,
    'description': description,
    'thumbnail': thumbnail,
  };
}
