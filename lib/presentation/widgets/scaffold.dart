import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_controller.dart';

class MyScaffold extends StatelessWidget {
  MyScaffold(
      {this.background,
      this.appBar,
      required this.title,
      required this.body,
      this.bottomMenuIndex,
      this.bottomNavigationBar,
      this.backgroundAppBar,
      this.hasLeadingIcon = true});

  final Color? background;
  final Color? backgroundAppBar;
  final String? title;

  final Widget body;
  final AppBar? appBar;
  final int? bottomMenuIndex;
  final Widget? bottomNavigationBar;
  final bool hasLeadingIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: title != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                leading: hasLeadingIcon
                    ? IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Get.back();
                          Get.find<CartController>().hasLeadingIcon.value =
                              false;
                        },
                      )
                    : null,
                title: Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Text(title!),
                ),
                actions: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                      )
                    ],
                  )
                ],
              ),
            )
          : appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
