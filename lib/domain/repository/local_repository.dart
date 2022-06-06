import 'package:sajilo_dokan/domain/model/user_model.dart';

abstract class LocalRepositoryInterface {
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<void> clearAllData();
  Future<void> saveToken(String? token);
  Future<void> saveRefreshToken(String? refreshTokle);
  Future<UserModel?> saveUser(UserModel? user);
  Future<UserModel?> getUser();
}
