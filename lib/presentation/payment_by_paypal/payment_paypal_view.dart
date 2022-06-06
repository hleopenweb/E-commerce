import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'payment_paypal_controller.dart';

class PaymentPaypalView extends GetView<PaymentPaypalController> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Thanh toán Paypal',
      hasLeadingIcon: false,
      body: Builder(
        builder: (BuildContext context) {
          return WebView(
            initialUrl: controller.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {},
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              } else if (request.url
                  .startsWith('https://cnpm-ecommerce.herokuapp.com')) {
                Get.toNamed(Routes.paymentSuccess);
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          );
        },
      ),
    );
  }
}
