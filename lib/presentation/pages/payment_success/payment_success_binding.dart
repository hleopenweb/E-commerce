import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/payment_cash/payment_cash_controller.dart';
import 'package:sajilo_dokan/presentation/pages/payment_success/payment_success_controller.dart';


class PaymentSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentSuccessController>(
      () => PaymentSuccessController(),
    );
  }
}
