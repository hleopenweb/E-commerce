import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/model/user_service.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';
import 'package:sajilo_dokan/domain/request/login_request.dart';
import 'package:sajilo_dokan/domain/request/new_password_request.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordController(
      {required this.localRepositoryInterface,
      required this.userRepositoryInterface});

  final LocalRepositoryInterface localRepositoryInterface;
  final UserRepositoryInterface userRepositoryInterface;

  final oldPasswordTextController = TextEditingController();
  final reTypePasswordTextController = TextEditingController();
  final newPasswordTextController = TextEditingController();

  final isLoading = false.obs;

  final showNewPassword = true.obs;
  final showOldPassword = true.obs;
  final showRetypePassword = true.obs;

  void toggleShowNewPassword() {
    showNewPassword.toggle();
  }

  void toggleShowOldPassword() {
    showOldPassword.toggle();
  }

  void toggleShowRetypePassword() {
    showRetypePassword.toggle();
  }

  Future<bool> changePassword() async {
    final oldPassword = oldPasswordTextController.text;
    final newPassword = newPasswordTextController.text;
    try {
      isLoading(true);
      final changePasswordResponse =
          await userRepositoryInterface.changePassword(NewPasswordRequest(
        email: UserModel().email,
        oldPassword: oldPassword,
        password: newPassword,
      ));
      if (changePasswordResponse != null) {
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
}
