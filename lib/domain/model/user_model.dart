class UserModel {
  static UserModel? _instance;

  /// Constructor
  UserModel._();

  factory UserModel() {
    return _instance ??= UserModel._();
  }

  void destroyInstance() {
    _instance = null;
  }

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
  String? accessToken;
  String? refreshToken;

  void create({
    int? id,
    DateTime? createdDate,
    DateTime? modifiedDate,
    String? createdBy,
    String? modifiedBy,
    String? userName,
    String? password,
    String? name,
    String? address,
    String? phoneNumber,
    String? email,
    int? gender,
    String? profilePicture,
    int? enabled,
    String? accessToken,
    String? refreshToken,
  }) {
    this.id = id;
    this.createdBy = createdBy;
    this.modifiedBy = modifiedBy;
    this.userName = userName;
    this.password = password;
    this.name = name;
    this.address = address;
    this.phoneNumber = phoneNumber;
    this.email = email;
    this.gender = gender;
    this.profilePicture = profilePicture;
    this.enabled = enabled;
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }
}
