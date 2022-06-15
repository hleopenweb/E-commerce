import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/change_password/widgets/change_form.dart';
import 'package:sajilo_dokan/presentation/pages/login/views/form.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';
import 'change_password_controller.dart';

class ChangePasswordScreen extends GetWidget<ChangePasswordController> {
  Future<void> login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    // final result = await controller.changePassword();
    // if (result) {
    //   Get.offAllNamed(Routes.landingHome);
    // } else {
    //   Get.snackbar('Xảy ra lỗi', 'Vui lòng kiểm tra lại mật khẩu vừa nhập',
    //       snackStyle: SnackStyle.FLOATING);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: ChangeForm(
                  password: controller.passwordTextController,
                  changePassword: () {},
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
          );
        }),
      ),
    );
  }
}
