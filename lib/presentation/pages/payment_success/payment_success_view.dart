import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_controller.dart';
import 'package:sajilo_dokan/presentation/pages/payment_success/widgets/empty_section.dart';
import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';
import 'payment_success_controller.dart';

class PaymentSuccessView extends GetView<PaymentSuccessController> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Thanh toán',
      background: Colors.white,
      hasLeadingIcon: false,
      body: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmptySection(
              emptyImg: 'assets/success.gif',
              emptyMsg: 'Thanh toán thành công',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 25),
              child: Text(
                'Vui lòng trở lại trang chủ',
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnam(
                  fontSize: 18.0,
                  color: Color(0xFF808080),
                ),
              ),
            ),
            ElevatedButton(
              child: Text(
                'Trở về trang chủ',
                style: GoogleFonts.beVietnam(fontSize: 18, color: Colors.white),
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                  (Set<MaterialState> states) {
                    return EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    );
                  },
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFFF8084)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              onPressed: () {
               Get.find<CartController>().fetchCartList(
                  page: 0,
                  limit: 100,
                  sort: 'id,ASC',
                  customerId: UserModel().id,
                );
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
