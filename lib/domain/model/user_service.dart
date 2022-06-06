import 'dart:convert';

class UserService {
  UserService({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.userName,
    this.password,
    this.name,
    this.address,
    this.phoneNumber,
    this.email,
    this.gender,
    this.profilePicture,
    this.enabled,
  });

  int? id;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? createdBy;
  String? modifiedBy;
  String? userName;
  String? password;
  String? name;
  String? address;
  String? phoneNumber;
  String? email;
  int? gender;
  String? profilePicture;
  int? enabled;

  factory UserService.fromRawJson(String str) => UserService.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserService.fromJson(Map<String, dynamic> json) => UserService(
    id: json['id'],
    createdDate: json['createdDate'],
    modifiedDate: json['modifiedDate'],
    createdBy: json['createdBy'],
    modifiedBy: json['modifiedBy'],
    userName: json['userName'],
    password: json['password'],
    name: json['name'],
    address: json['address'],
    phoneNumber: json['phoneNumber'],
    email: json['email'],
    gender: json['gender'],
    profilePicture: json['profilePicture'],
    enabled: json['enabled'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdDate': createdDate,
    'modifiedDate': modifiedDate,
    'createdBy': createdBy,
    'modifiedBy': modifiedBy,
    'userName': userName,
    'password': password,
    'name': name,
    'address': address,
    'phoneNumber': phoneNumber,
    'email': email,
    'gender': gender,
    'profilePicture': profilePicture,
    'enabled': enabled,
  };
}
