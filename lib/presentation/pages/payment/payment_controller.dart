import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PaymentController extends GetxController {
  final groupValue = 0.obs;
  List<String> payments=['Tiền mặt','PayPal'];
  final paymentLabels = [
    'Credit card / Debit card',
    'Cash on delivery',
    'Paypal',
    'Google wallet',
  ];

  final paymentIcons = [
    Icons.money_off,
    Icons.payment,
  ];

  late int args;

  @override
  void onInit() {
    args = Get.arguments as int;
    super.onInit();
  }
}
