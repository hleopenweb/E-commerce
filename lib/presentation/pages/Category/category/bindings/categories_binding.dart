import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category/controller/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CategoryController(
        localRepositoryInterface: Get.find(),
        apiRepositoryInterface: Get.find(),
      ),
    );
  }
}
