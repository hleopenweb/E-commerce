import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';
import 'package:sajilo_dokan/domain/request/cancel_order_request.dart';
import 'package:sajilo_dokan/domain/response/order_response.dart';

class OrderController extends GetxController {
  OrderController({
    required this.apiRepositoryInterface,
    required this.localRepositoryInterface,
    required this.userRepositoryInterface,
  });

  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;
  final UserRepositoryInterface userRepositoryInterface;

  RxInt quantity = 2.obs;
  RxBool loading = false.obs;

  RxBool isVisible = true.obs;

  RxBool isOrderLoad = false.obs;

  final hasLeadingIcon = false.obs;

  final page = 0.obs;
  final sort = 'ASC'.obs;

  final Rx<OrderResponse> orderResponse = OrderResponse(content: []).obs;

  final RxList<OrderContent> contentOrderList = RxList();

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchOrderList(
      page: page.value,
      limit: 200,
      sort: 'id,$sort',
      customerId: UserModel().id,
    );
  }

  Future<void> fetchOrderList({
    int? limit,
    int? page,
    String? sort,
    int? customerId,
  }) async {
    contentOrderList.clear();
    try {
      isOrderLoad(true);
      orderResponse.value = (await apiRepositoryInterface.getOrderHistory(
            limit,
            page,
            sort,
            customerId,
          )) ??
          OrderResponse();
      if (orderResponse.value.content!.isNotEmpty) {
        contentOrderList.addAll(orderResponse.value.content!);
      }
      contentOrderList.value = contentOrderList.reversed.toList();
    } catch (e) {
      isOrderLoad(false);
      rethrow;
    } finally {
      isOrderLoad(false);
    }
  }

  Future<void> cancelOrderCart(OrderContent item) async {
    final res = await apiRepositoryInterface.cancelOrder(
      CancelOrderRequest(
        userId: UserModel().id!,
        status: 'CANCELLED',
      ),
      item.id ?? 0,
    );
    if (res != null) {
      await fetchOrderList(
        page: page.value,
        limit: 200,
        sort: 'id,$sort',
        customerId: UserModel().id,
      );
    }
  }

  void showDeleteOrderDialog(OrderContent item) {
    showDialog(
      context: Get.context!,
      builder: (_) => NetworkGiffyDialog(
        image: Image.network(
            'https://goi2l15njka4zxbg462znzuu-wpengine.netdna-ssl.com/wp-content/uploads/2017/09/ecommerce-cart-gif.gif'),
        title: Text(
          'Bạn có chắc chắn muốn hủy đơn hàng này',
          textAlign: TextAlign.center,
          style: GoogleFonts.beVietnam(
              fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        onOkButtonPressed: () async {
          Get.back();
          await cancelOrderCart(item);
        },
        onCancelButtonPressed: () {
          Get.back();
        },
      ),
    );
  }
}
