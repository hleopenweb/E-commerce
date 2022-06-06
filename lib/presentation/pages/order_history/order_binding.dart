import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_controller.dart';

import 'order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => OrderController(
        apiRepositoryInterface: Get.find(),
        localRepositoryInterface: Get.find(),
        userRepositoryInterface: Get.find(),
      ),
    );
  }
}
