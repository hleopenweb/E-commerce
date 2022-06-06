import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sajilo_dokan/domain/model/brand.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/response/category.dart';
import 'package:sajilo_dokan/domain/response/product.dart';

class ProductController extends GetxController {
  ProductController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface});

  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  RxBool isLoadingProduct = false.obs;
  RxBool isLoadMoreProduct = false.obs;

  final Rx<Product> product = Product().obs;
  final RxList<Content> categoryProducts = RxList();
  final RxSet<Brand> brandProducts = RxSet();
  late ScrollController scrollController;
  late final TextEditingController textEditingController;

  final box = GetStorage();
  final page = 0.obs;
  final sort = 'ASC'.obs;
  final search = ''.obs;
  RxBool isGrid = false.obs;
  RxBool isChooseAll = true.obs;
  late Category args;

  void changeGridMode(bool val) {
    box.write('gridded', !val);
    isGrid(!val);
  }

  void initGridMode() => isGrid(box.read('gridded') ?? false);

  @override
  Future<void> onInit() async {
    super.onInit();

    textEditingController = TextEditingController();
    scrollController = ScrollController()..addListener(_scrollListener);
    if (Get.arguments != null) {
      args = Get.arguments as Category;
      await loadCategoryProducts(
        page: page.value,
        limit: 6,
        sort: 'price,$sort',
        productName: search.value,
        categoryId: args.id,
        isLoadProduct: false,
      );
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      if (categoryProducts.length == product.value.totalElements) return;
      print('scroll');
      page.value += 1;
      await loadCategoryProducts(
        page: page.value,
        limit: 6,
        sort: 'price,$sort',
        productName: search.value,
        categoryId: args.id,
        isLoadProduct: true,
      );
    }
  }

  Future<void> searchProduct() async {
    page.value = 0;
    categoryProducts.clear();
    brandProducts.clear();
    await loadCategoryProducts(
      page: page.value,
      limit: 6,
      sort: 'price,$sort',
      productName: search.value,
      categoryId: args.id,
      isLoadProduct: false,
    );
      for (final element in brandProducts) {
        if(element.brand == search.value) {
          element.isChoose!.value = true;
        }
      }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    initGridMode();
  }

  Future<void> loadCategoryProducts(
      {int? limit,
      int? page,
      String? sort,
      String? productName,
      int? categoryId,
      bool? isLoadProduct}) async {
    try {
      isLoadProduct! ? isLoadMoreProduct(true) : isLoadingProduct(true);
      product.value = (await apiRepositoryInterface.getCategoryProduct(
            limit,
            page,
            sort,
            productName,
            categoryId,
          )) ??
          Product();
      if (product.value.content!.isNotEmpty) {
        categoryProducts.addAll(product.value.content!);
      }
      for (final element in categoryProducts) {
        brandProducts.add(Brand(brand: element.brand, isChoose: false.obs));
      }
      print(categoryProducts.length);
    } catch (e) {
      isLoadProduct! ? isLoadMoreProduct(false) : isLoadingProduct(false);
      rethrow;
    } finally {
      isLoadProduct! ? isLoadMoreProduct(false) : isLoadingProduct(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(_scrollListener);
  }
}
