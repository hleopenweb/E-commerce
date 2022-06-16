import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sajilo_dokan/config/colors.dart';

import 'package:sajilo_dokan/presentation/pages/account/views/list_item_cart.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';

class AccountScreen extends StatelessWidget {
  final int index;

  AccountScreen(this.index);

  final controller = Get.find<HomeController>();
  final googlesignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  Future<void> logout() async {
    await googlesignIn.signOut();
    controller.logout();
    Get.offAllNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final user = controller.user();
    return Obx(() {
      if (controller.isLoading.value) {
        return MyScaffold(
          background: kBackGround,
          hasLeadingIcon: false,
          title: 'Tài khoản',
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListItemCart(
                    icon: Icons.person,
                    title: user.userName ?? '',
                    onpressed: () {
                      Get.toNamed(Routes.profile);
                    },
                  ),
                  ListItemCart(
                    icon: Icons.badge,
                    title: 'Đơn hàng của tôi',
                    onpressed: () {
                      Get.toNamed(Routes.orderHistory);
                    },
                  ),
                  ListItemCart(
                    icon: Icons.location_city,
                    title: 'Đổi mật khẩu',
                    onpressed: () {
                      Get.toNamed(Routes.changePassword);
                    },
                  ),
                  ListItemCart(
                    icon: Icons.settings,
                    title: 'Cài đặt',
                    onpressed: () {},
                  ),
                  ListItemCart(
                    icon: Icons.chat,
                    title: 'Liên hệ với chúng tôi',
                    onpressed: () {},
                  ),
                  if (user.userName == null)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                        ),
                        onPressed: () {
                          Get.offNamed(Routes.login);
                        },
                        child: Text('Đăng kí/Đăng nhập'),
                      ),
                    )
                  else
                    SizedBox(),
                  if (user.userName != null)
                    ListItemCart(
                      icon: Icons.logout,
                      title: 'Đăng xuất',
                      onpressed: logout,
                    )
                  else
                    SizedBox(),
                ],
              ),
            ),
          ),
          bottomMenuIndex: index,
        );
      } else {
        return Container();
      }
    });
  }
}
