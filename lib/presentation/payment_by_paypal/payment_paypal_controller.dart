import 'dart:convert';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPaypalController extends GetxController {
  late WebViewController webViewController;
  late String url;

  @override
  Future<void> onInit() async {
    url = Get.arguments as String;
    super.onInit();
  }
}
