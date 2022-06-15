import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_controller.dart';

import 'change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ChangePasswordController(
        localRepositoryInterface: Get.find(),
        userRepositoryInterface: Get.find(),
      ),
    );
  }
}
