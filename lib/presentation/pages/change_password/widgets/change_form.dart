import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/colors.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/default_btn.dart';
import 'package:sajilo_dokan/presentation/widgets/default_logo.dart';
import '../../../../constant.dart';

class ChangeForm extends StatelessWidget {
  ChangeForm({
    this.password,
    this.changePassword,
  });

  final TextEditingController? password;
  final VoidCallback? changePassword;

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;

  final controller = Get.find<LoginController>();

  final List<String> listGenders = ['Nam', 'Nữ', 'Không xác định'];

  Future<void> socialLogin(String? idToken, String provider) async {
    final result = await controller.googleAuth(idToken, provider);
    if (result) {
      Get.offAllNamed(Routes.landingHome);
    } else {
      Get.snackbar('Error', 'Incorrect Password');
    }
  }

  Widget buildChangePassword() {
    const title = 'Thay đổi mật khẩu';

    final btnText = controller.isSignIn.value ? 'Đăng nhập' : 'Đăng kí';

    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(AppSizes.sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultLogo(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.beVietnam(
                      textStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        controller: password,
                        style: GoogleFonts.beVietnam(),
                        obscureText: controller.showPassword.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mật khẩu không được bỏ trống';
                          }
                          if (!(value.length > 6)) {
                            return 'Mật khấu phải lớn hơn 6 kí tự';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.security,
                            color: Colors.black38,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.toggleShowPassword();
                            },
                            icon: controller.showPassword.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          hintText: 'Mật khẩu',
                          hintStyle: kHintTextStyle,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () => changePassword!(),
                child: DefaultBTN(
                  btnText: btnText,
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return buildChangePassword();
    });
  }
}
