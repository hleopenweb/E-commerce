import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category/controller/categories_controller.dart';
import 'package:sajilo_dokan/presentation/pages/Category/product/controller/products_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProductController(
        localRepositoryInterface: Get.find(),
        apiRepositoryInterface: Get.find(),
      ),
    );
  }
}
