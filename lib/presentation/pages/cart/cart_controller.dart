import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';
import 'package:sajilo_dokan/domain/request/add_cart_request.dart';
import 'package:sajilo_dokan/domain/response/cart_response.dart';

class CartController extends GetxController {
  CartController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface,
      required this.userRepositoryInterface});

  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;
  final UserRepositoryInterface userRepositoryInterface;

  RxInt quantity = 2.obs;
  RxBool loading = false.obs;

  RxBool isVisible = true.obs;

  RxBool isCartLoad = false.obs;

  bool get isAllCartSelected => selectedCarts.length == contentCartList.length;

  RxDouble totalAmount = 0.0.obs;
  var total;

  final hasLeadingIcon = false.obs;

  Iterable<ContentCart> get selectedCarts =>
      contentCartList.where((p0) => p0.isCheck.value == true);

  final page = 0.obs;
  final sort = 'ASC'.obs;

  final Rx<CartResponse> cartResponse = CartResponse().obs;
  final RxList<ContentCart> contentCartList = RxList();

  @override
  void onInit() {
    super.onInit();
    fetchCartList(
      page: page.value,
      limit: 100,
      sort: 'id,$sort',
      customerId: UserModel().id,
    );
  }

  Future<void> fetchCartList({
    int? limit,
    int? page,
    String? sort,
    int? customerId,
  }) async {
    contentCartList.clear();
    try {
      isCartLoad(true);
      cartResponse.value = (await apiRepositoryInterface.getCartList(
            limit,
            page,
            sort,
            customerId,
          )) ??
          CartResponse();
      if (cartResponse.value.content!.isNotEmpty) {
        contentCartList.addAll(cartResponse.value.content!);
      }
      totalAmount.value = 0;
      for (final element in contentCartList) {
        totalAmount.value = totalAmount.value +
            ((element.salePrice?.toInt() ?? 0) * element.quantity!);
      }
    } catch (e) {
      isCartLoad(false);
      rethrow;
    } finally {
      isCartLoad(false);
    }
  }

  Future<void> addToCart(int? productId, int? quantity, int? salePrice) async {
    if (!isCartLoad.value) {
      var result = await apiRepositoryInterface.addToCart(AddCartRequest(
          customerId: UserModel().id,
          productId: productId,
          quantity: quantity,
          salePrice: salePrice));
      await fetchCartList(
        page: page.value,
        limit: 100,
        sort: 'id,$sort',
        customerId: UserModel().id,
      );
      if (result != null) {
        Get.snackbar(
          'Thêm giỏ hàng thành công!',
          '',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          borderRadius: 0,
          backgroundColor: Colors.black.withOpacity(0.8),
          isDismissible: true,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(5),
          animationDuration: Duration(seconds: 1),
          duration: Duration(seconds: 2),
        );
      }
    }
  }

  Future<void> removeProductFromCart() async {
    for (final element in selectedCarts) {
      isCartLoad.value = true;
      await apiRepositoryInterface.deleteCart(element.id);
      isCartLoad.value = false;
    }
    await fetchCartList(
      page: page.value,
      limit: 100,
      sort: 'id,$sort',
      customerId: UserModel().id,
    );
  }

  void clearCart() {
    contentCartList.clear();
  }

  // Future<void> refreshTotal() async {
  //   total = 0.0;
  //   for (final element in contentCartList) {
  //     if (selectedCarts.contains(element.id)) {
  //       total += element.amount;
  //     }
  //   }
  //   totalAmount(total);
  // }

  // void selectAllCart() {
  //   if (selectedCarts.length == contentCartList.length) {
  //     selectedCarts([]);
  //   } else {
  //     selectedCarts([]);
  //     for (var element in contentCartList) {
  //       selectedCarts.add(element.id);
  //     }
  //   }
  //   refreshTotal();
  // }

  // void selectCart(Cart cart) {
  //   if (!selectedCarts.contains(cart.id)) {
  //     selectedCarts.add(cart.id);
  //   } else {
  //     selectedCarts.remove(cart.id);
  //   }
  //   refreshTotal();
  // }

  Future<void> addQuantity(int? id, int quantity) async {
    final user = await localRepositoryInterface.getUser();
    final token = user?.accessToken;
    final result =
        await apiRepositoryInterface.addQuantity(token, id, quantity);

    if (result == true) {
      AppWidget().snackBar('Added to cart successfully!');
      await fetchCartList();
    }
  }

  Future<void> updateCart(ContentCart item) async {
    if (item.quantity! <= 0) {
      showDialogDelete(item.id);
    } else {
      isCartLoad.value = true;
      final res = await apiRepositoryInterface.updateCart(
        AddCartRequest(
            customerId: UserModel().id,
            productId: item.productId,
            quantity: item.quantity,
            salePrice: item.salePrice?.toInt() ?? 0),
        item.id ?? 0,
      );
      isCartLoad.value = false;
      if (res != null) {
        await fetchCartList(
          page: page.value,
          limit: 100,
          sort: 'id,$sort',
          customerId: UserModel().id,
        );
      }
    }
  }

  void showDialogDelete(int? id) {
    showDialog(
        context: Get.context!,
        builder: (_) => NetworkGiffyDialog(
              image: Image.network(
                  'https://goi2l15njka4zxbg462znzuu-wpengine.netdna-ssl.com/wp-content/uploads/2017/09/ecommerce-cart-gif.gif'),
              title: Text(
                'Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng',
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnam(
                    fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              onOkButtonPressed: () async {
                if (id != null) {
                  isCartLoad.value = true;
                  await apiRepositoryInterface.deleteCart(id);
                  isCartLoad.value = false;
                  fetchCartList(
                    page: page.value,
                    limit: 100,
                    sort: 'id,$sort',
                    customerId: UserModel().id,
                  );
                  Get.back();
                }
              },
              onCancelButtonPressed: () {
                Get.back();
              },
            ));
  }

  void showButtomSheed(
      BuildContext context, VoidCallback onTap, int? id) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text('Selete Quantity'),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.cancel)),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                        10,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  quantity(index + 1);
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: quantity.value == (index + 1)
                                              ? Colors.redAccent
                                              : Colors.black)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text((1 + index).toString()),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  addQuantity(id, quantity.value);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  color: Colors.redAccent,
                  width: double.infinity,
                  child: Center(
                    child: Text('Done'),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
