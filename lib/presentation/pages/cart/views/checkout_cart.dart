import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/utils/converter_currency.dart';

import '../cart_controller.dart';

class CheckoutCart extends StatelessWidget {
  final totalAmount;

  CheckoutCart({this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Tổng số tiền',
                      style: GoogleFonts.beVietnam(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    formatCurrency(totalAmount.toInt()),
                    style: GoogleFonts.beVietnam(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.payment, arguments: totalAmount.toInt());
              Get.find<CartController>().hasLeadingIcon.value = false;
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Text(
                    'Thanh toán',
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.beVietnam(
                        fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
