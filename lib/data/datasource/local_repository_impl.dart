import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefToken = 'TOKEN';
const _prefRefreshToken = 'REFRESH_TOKEN';
const _prefUsername = 'USERNAME';
const _prefName = 'NAME';
const _prefId = 'ID';
const _prefAddress = 'ADDRESS';
const _prefPhoneNumber = 'PHONE';
const _prefEmail = 'EMAIL';
const _prefGender = 'GENDER';

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> clearAllData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<String?> getToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(_prefToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(_prefRefreshToken);
  }

  @override
  Future<UserModel?> getUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final username = sharedPreferences.getString(_prefUsername);
    final name = sharedPreferences.getString(_prefName);
    final id = sharedPreferences.getString(_prefId);
    final address = sharedPreferences.getString(_prefAddress);
    final phoneNumber = sharedPreferences.getString(_prefPhoneNumber);
    final email = sharedPreferences.getString(_prefEmail);
    final gender = sharedPreferences.getString(_prefGender);
    final token = sharedPreferences.getString(_prefToken);
    final refreshToken = sharedPreferences.getString(_prefRefreshToken);
    if( id == null || gender ==null) {
      return null;
    }
    UserModel().create(
      id: int.parse(id),
      userName: username,
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      email: email,
      gender: int.parse(gender),
      accessToken: token,
      refreshToken: refreshToken,
    );
    return UserModel();
  }

  @override
  Future<UserModel?> saveUser(UserModel? user) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(_prefName, user!.name ?? '');
    sharedPreferences.setString(_prefUsername, user.userName?? '');
    sharedPreferences.setString(_prefId, user.id.toString());
    sharedPreferences.setString(_prefAddress, user.address??'');
    sharedPreferences.setString(_prefPhoneNumber, user.phoneNumber??'');
    sharedPreferences.setString(_prefEmail, user.email??'');
    sharedPreferences.setString(_prefGender, user.gender.toString());
    sharedPreferences.setString(_prefRefreshToken, user.refreshToken??'');
    sharedPreferences.setString(_prefToken, user.accessToken??'');
    return user;
  }

  @override
  Future<void> saveToken(String? token) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(_prefToken, token!);
  }

  @override
  Future<void> saveRefreshToken(String? refreshToken) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(_prefRefreshToken, refreshToken!);
  }
}
