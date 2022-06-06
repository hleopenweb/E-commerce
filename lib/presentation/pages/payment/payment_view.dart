import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/colors.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';
import 'payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Thanh toán',
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Chọn phương thức thanh toán',
                  style: GoogleFonts.beVietnam(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: controller.payments
                    .asMap()
                    .entries
                    .map(
                      (e) => ListTile(
                        leading: Radio(
                          value: e.key,
                          activeColor: kPrimaryColor,
                          groupValue: controller.groupValue.value,
                          onChanged: (newValue) {
                            controller.groupValue.value =
                                int.parse(newValue.toString());
                          },
                        ),
                        title: Text(
                          e.value,
                          style: TextStyle(color: Color(0xFF303030)),
                        ),
                        trailing: Icon(
                          controller.paymentIcons[e.key],
                          color: Color(0xFFFF8084),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(
                  'Thanh toán',
                  style:
                      GoogleFonts.beVietnam(fontSize: 18, color: Colors.white),
                ),
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (Set<MaterialState> states) {
                      return EdgeInsets.symmetric(
                        horizontal: 120,
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
                  Get.toNamed(
                    Routes.paymentByCash,
                    arguments: [
                      {'totalAmount': controller.args},
                      {
                        'paymentMethod': controller.groupValue.value == 0
                            ? 'CASH'
                            : 'PAYMENT'
                      }
                    ],
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
