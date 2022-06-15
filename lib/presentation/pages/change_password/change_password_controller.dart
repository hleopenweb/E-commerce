import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/model/user_service.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';
import 'package:sajilo_dokan/domain/request/login_request.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordController(
      {required this.localRepositoryInterface,
      required this.userRepositoryInterface});

  final LocalRepositoryInterface localRepositoryInterface;
  final UserRepositoryInterface userRepositoryInterface;

  final passwordTextController = TextEditingController();
  final newPasswordTextController = TextEditingController();

  final isLoading = false.obs;

  final isValidPassword = false.obs;
  final showPassword = true.obs;

  void toggleShowPassword() {
    showPassword.toggle();
  }

  // Future<bool> changePassword() async {
    // final password = passwordTextController.text;
    // try {
    //   isLoading(true);
    //   final loginResponse = await userRepositoryInterface.login(LoginRequest(userName, password));
    //   if (loginResponse != null) {
    //     final userService = await getUserInfo(loginResponse.id!);
    //     if (userService != null) {
    //       UserModel().create(
    //         id: userService.id,
    //         userName: userService.userName,
    //         name: userService.name,
    //         address: userService.address,
    //         phoneNumber: userService.phoneNumber,
    //         email: userService.email,
    //         gender: userService.gender,
    //         accessToken: loginResponse.token,
    //         refreshToken: loginResponse.refreshToken,
    //       );
    //       await localRepositoryInterface.saveUser(UserModel());
    //       isLoading(false);
    //       return true;
    //     } else {
    //       isLoading(false);
    //       return false;
    //     }
    //   } else {
    //     isLoading(false);
    //     return false;
    //   }
    // } on Exception {
    //   isLoading(false);
    //   return false;
    // }
 // }

}
