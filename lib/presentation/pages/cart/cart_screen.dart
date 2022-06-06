import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_controller.dart';
import 'package:sajilo_dokan/presentation/pages/cart/views/checkout_cart.dart';
import 'package:sajilo_dokan/presentation/pages/cart/views/items_number.dart';
import 'package:sajilo_dokan/presentation/pages/details/view/cart_item_custom.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';
import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';

class CartScreen extends GetView<CartController> {
  CartScreen();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return MyScaffold(
        title: 'Giỏ hàng',
        hasLeadingIcon: controller.hasLeadingIcon.value,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Obx(() {
                            return ItemNuber(
                              itemNumber: controller.contentCartList.length,
                            );
                          }),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.removeProductFromCart();
                          },
                          child: Text(
                            'Xóa ',
                            style: GoogleFonts.beVietnam(
                              color: Colors.redAccent,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: TextButton(
                        onPressed: () {
                          controller.contentCartList.forEach((element) {
                            element.isCheck.value = true;
                          });
                          controller.contentCartList.refresh();
                        },
                        child: Text(
                          'Chọn tất cả',
                          style: GoogleFonts.beVietnam(
                            color: Colors.redAccent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return Column(children: [
                  if (!controller.isCartLoad.value)
                    ...List.generate(
                      controller.contentCartList.length,
                          (index) =>
                          CartItemCustom(
                            cartItem: controller.contentCartList[index],
                            onChanged: (value) {
                              controller.contentCartList[index].isCheck.value =
                                  value;
                              controller.contentCartList.refresh();
                            },
                            add: () async {
                              controller.contentCartList[index].quantity =
                                  controller.contentCartList[index].quantity! +
                                      1;
                              await controller
                                  .updateCart(
                                  controller.contentCartList[index]);
                            },
                            sub: () {
                              controller.contentCartList[index].quantity =
                                  controller.contentCartList[index].quantity! -
                                      1;
                              controller
                                  .updateCart(
                                  controller.contentCartList[index]);
                            },
                          ),
                    )
                  else
                    Container(
                      margin: EdgeInsets.only(top: 200),
                      child: LoadingWidget(),
                    )
                ]);
              }),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          return CheckoutCart(
            totalAmount: controller.totalAmount.value,
          );
        }),
      );
    });
  }
}
