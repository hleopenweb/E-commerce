import 'package:sajilo_dokan/domain/model/user_service.dart';
import 'package:sajilo_dokan/domain/request/login_request.dart';
import 'package:sajilo_dokan/domain/request/new_password_request.dart';
import 'package:sajilo_dokan/domain/request/register_request.dart';
import 'package:sajilo_dokan/domain/response/login_response.dart';
import 'package:sajilo_dokan/domain/response/register_response.dart';
import 'package:sajilo_dokan/domain/response/update_cart_response.dart';

abstract class UserRepositoryInterface {
  Future<UserService?> getUserFromId(int id);
  Future<LoginResponse?> login(LoginRequest login);
  Future<RegisterResponse?> register(RegisterRequest register);
  Future<LoginResponse?> googleSignIn(String? idToken, String provider);
  Future<bool> forgetPassword(String email);
  Future<String?> verifyForgetPasswordCode(String email, String otp);
  Future<LoginResponse?> createNewPassword(String token, String newPassword);
  Future<UpdateCartResponse?> changePassword(
      NewPasswordRequest passwordRequest);
  Future<LoginResponse?> refreshToken(String refreshToken);
}
