import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_controller.dart';
import 'package:sajilo_dokan/presentation/pages/login/views/form.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';

class LoginScreen extends GetWidget<LoginController> {
  Future<void> login(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final result = await controller.login();
    if (result) {
      Get.offAllNamed(Routes.landingHome);
    } else {
      Get.snackbar('Xảy ra lỗi', 'Vui lòng kiểm tra thông tin đăng nhập',
          snackStyle: SnackStyle.FLOATING);
    }
  }

  Future<void> register(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    print('register call in screen');
    final result = await controller.register();
    if (result) {
      Get.offAllNamed(Routes.login);
      Get.snackbar('Đăng kí thành công', 'Vui lòng kiểm tra email để xác nhận',
          snackStyle: SnackStyle.FLOATING);
    } else {
      Get.snackbar(
        'Xảy ra lỗi',
        'Vui lòng kiểm tra thông tin đăng kí',
        snackStyle: SnackStyle.FLOATING,
      );
    }
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
                child: SignForm(
                  name: controller.nameTextController,
                  email: controller.emailTextController,
                  password: controller.passwordTextController,
                  userName: controller.userNameTextController,
                  phone: controller.phoneNumberTextController,
                  logOrRegAction: controller.isSignIn.value
                      ? () => login(context)
                      : () => register(context),
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
