import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:sajilo_dokan/domain/exception/auth_exception.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/model/user_service.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';
import 'package:sajilo_dokan/domain/request/login_request.dart';
import 'package:sajilo_dokan/domain/request/register_request.dart';

enum SignType { sigIn, signUp }

class LoginController extends GetxController {
  LoginController(
      {required this.localRepositoryInterface,
      required this.userRepositoryInterface});

  final LocalRepositoryInterface localRepositoryInterface;
  final UserRepositoryInterface userRepositoryInterface;

  final nameTextController = TextEditingController();
  final userNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final emailTextController = TextEditingController();
  int gender = -1.obs;

  final isLoading = false.obs;

  final isValidEmail = false.obs;
  final isValidPassword = false.obs;
  final isSignIn = true.obs;
  final showPassword = true.obs;

  void toggleFormType() {
    isSignIn(!isSignIn.value);
  }

  void toggleShowPassword() {
    showPassword.toggle();
  }

  Future<bool> login() async {
    final userName = userNameTextController.text;
    final password = passwordTextController.text;
    try {
      isLoading(true);
      final loginResponse = await userRepositoryInterface.login(LoginRequest(userName, password));
      if (loginResponse != null) {
        final userService = await getUserInfo(loginResponse.id!);
        if (userService != null) {
          UserModel().create(
            id: userService.id,
            userName: userService.userName,
            name: userService.name,
            address: userService.address,
            phoneNumber: userService.phoneNumber,
            email: userService.email,
            gender: userService.gender,
            accessToken: loginResponse.token,
            refreshToken: loginResponse.refreshToken,
          );
          await localRepositoryInterface.saveUser(UserModel());
          isLoading(false);
          return true;
        } else {
          isLoading(false);
          return false;
        }
      } else {
        isLoading(false);
        return false;
      }
    } on Exception {
      isLoading(false);
      return false;
    }
  }

  Future<UserService?> getUserInfo(int id) async {
    try {
      final userResponse = await userRepositoryInterface.getUserFromId(id);
      if (userResponse != null) {
        return userResponse;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<bool> register() async {
    final name = nameTextController.text;
    final email = emailTextController.text;
    final password = passwordTextController.text;
    final phone = phoneNumberTextController.text;
    final userName = userNameTextController.text;
    try {
      isLoading(true);
      final registerResponse = await userRepositoryInterface.register(
        RegisterRequest(
          name: name,
          email: email,
          password: password,
          phone: phone,
          userName: userName,
          gender: gender,
        ),
      );
      if (registerResponse != null) {
          isLoading(false);
          return true;
      } else {
        isLoading(false);
        return false;
      }
    } on Exception {
      isLoading(false);
      return false;
    }
  }

  Future<bool> googleAuth(String? idToken, String provider) async {
    try {
      isLoading(true);
      final loginResponse =
          await userRepositoryInterface.googleSignIn(idToken, provider);
      if (loginResponse != null) {
        // await localRepositoryInterface.saveToken(loginResponse.token);
        // await localRepositoryInterface.saveUser(loginResponse.user);
        return true;
      } else {
        isLoading(false);
      }

      return false;
    } on AuthException catch (_) {
      isLoading(false);
      return false;
    }
  }
}
