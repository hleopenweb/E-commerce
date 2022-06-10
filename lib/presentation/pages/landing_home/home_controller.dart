import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';
import 'package:sajilo_dokan/domain/response/product.dart';

class HomeController extends GetxController {
  HomeController({
    required this.userRepositoryInterface,
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  final UserRepositoryInterface userRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;

  Rx<UserModel> user = UserModel().obs;
  RxInt selectedIndex = 0.obs;
  final Rx<Product> product = Product().obs;
  final RxList<Content> categoryProducts = RxList();

  final page = 0.obs;
  final search = ''.obs;
  late ScrollController scrollController;
  RxBool isLoadingProduct = false.obs;
  RxBool isLoadingProductRecommend = false.obs;
  RxBool isLoadMoreProduct = false.obs;
  RxBool isLoading = true.obs;
  final TextEditingController textEditingController  = TextEditingController();


  RxBool isFavorite = false.obs;

  @override
  void onReady() {
    loadUser();
    super.onReady();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
    await fetchProduct();
  }

  Future<void> _scrollListener() async {
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      if (categoryProducts.length == product.value.totalElements) return;
      print('scroll');
      page.value += 1;
      await loadCategoryProducts(
        page: page.value,
        limit: 10,
        sort: 'price,ASC',
        productName: search.value,
        isLoadProduct: true,
      );
    }
  }

  Future<void> fetchProduct() async {
    page.value = 0;
    categoryProducts.clear();
    await loadCategoryProducts(
      page: page.value,
      limit: 10,
      sort: 'price,ASC',
      productName: search.value,
      isLoadProduct: false,
    );
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

  void loadUser() {
    localRepositoryInterface.getUser().then((value) => user(value));
  }

  void updateIndexSelected(int index) {
    selectedIndex(index);
  }

  Future<void> logout() async {
    await localRepositoryInterface.clearAllData();
    UserModel().destroyInstance();
  }

  void favoritebtn() {
    isFavorite.value = !isFavorite.value;
  }
}
