import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/payment_cash/payment_cash_controller.dart';


class PaymentCashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentCashController>(
      () => PaymentCashController(
        apiRepositoryInterface: Get.find()
      ),
    );
  }
}
