import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/account/accout_screen.dart';
import 'package:sajilo_dokan/presentation/pages/change_password/widgets/change_form.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';
import 'change_password_controller.dart';

class ChangePasswordScreen extends GetWidget<ChangePasswordController> {
  Future<void> changePassword(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final result = await controller.changePassword();
    if (result) {

      Get.find<HomeController>().logout();
      Get.offAllNamed(Routes.login);
      Get.snackbar('Đổi mật khẩu thành công', 'Vui lòng tiến hành đăng nhập bằng mật khẩu mới',
          snackStyle: SnackStyle.FLOATING);
    } else {
      Get.snackbar('Không thay đổi được mật khẩu', 'Đã có lỗi xảy ra',
          snackStyle: SnackStyle.FLOATING);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: ChangeForm(
                oldPassword: controller.oldPasswordTextController,
                newPassword: controller.newPasswordTextController,
                reTypePassword: controller.reTypePasswordTextController,
                changePassword: () =>changePassword(context),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey.withOpacity(0.5),
                  child: LoadingWidget(),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
