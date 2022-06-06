import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {

  LoadingWidget({
    Key? key,
  }) : super(key: key);
  final size = Get.size.shortestSide;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Lottie.asset(
        'assets/images/loading.json',
        fit: BoxFit.cover,
        width: size * 0.15,
        height: size * 0.15,
      ),
    );
  }
}
