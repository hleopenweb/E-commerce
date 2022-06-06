import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/response/category.dart';
import 'package:sajilo_dokan/domain/response/product.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';


class CategoryController extends GetxController {
  CategoryController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface});

  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  RxList<Category> categoriesList = RxList();
  RxBool isLoadingCategory = false.obs;
  RxList<Product> categoryProducts = RxList();

  @override
  Future<void> onReady() async {
    await loadCategories();
    super.onReady();
  }

  Future<void> loadCategories() async {
    try {
      isLoadingCategory(true);
      categoriesList.value = await apiRepositoryInterface.getCategories() ?? [];
    } catch (e) {
      isLoadingCategory(false);
      rethrow;
    } finally {
      isLoadingCategory(false);
    }
  }

  Future<void> openCategoryProductScreen(Category category) async {
    Get.toNamed(Routes.categoryProduct, arguments: category);
  }
}
