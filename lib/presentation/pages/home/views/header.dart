import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/config/text_theme.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';

class Header extends StatelessWidget {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        height: 42,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller.textEditingController,
          onSubmitted: (value) {
            controller.search.value = value;
            controller.fetchProduct();
          },
          style: kDefaultInput,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm',
            prefixIcon: Icon(
              Icons.search,
              size: 24,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
