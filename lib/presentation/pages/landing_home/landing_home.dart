import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category/views/category_screen.dart';
import 'package:sajilo_dokan/presentation/pages/account/accout_screen.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_screen.dart';

import 'package:sajilo_dokan/presentation/pages/home/home_screen.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/widgets/bottom_menu.dart';

class LandingHome extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          onWillPop: () async => false,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  final int currentIndex = controller.selectedIndex.value;
                  return IndexedStack(
                    index: currentIndex,
                    children: [
                      Home(
                        index: currentIndex,
                      ),
                      CategoryScreen(),
                      CartScreen(),
                      AccountScreen(currentIndex)
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => SajilodokanBottomMenu(
            bottomMenuIndex: controller.selectedIndex.value,
            onChanged: (index) {
              controller.updateIndexSelected(index);
            },
          ),
        ));
  }
}
