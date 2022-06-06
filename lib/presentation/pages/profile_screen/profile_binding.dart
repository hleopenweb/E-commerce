import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/payment_cash/payment_cash_controller.dart';
import 'package:sajilo_dokan/presentation/pages/profile_screen/profile_controller.dart';


class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        apiRepositoryInterface: Get.find()
      ),
    );
  }
}
