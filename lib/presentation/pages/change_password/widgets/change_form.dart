import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/colors.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/change_password/change_password_controller.dart';
import 'package:sajilo_dokan/presentation/widgets/default_btn.dart';
import 'package:sajilo_dokan/presentation/widgets/default_logo.dart';
import '../../../../constant.dart';

class ChangeForm extends StatelessWidget {
  ChangeForm({
    this.oldPassword,
    this.newPassword,
    this.reTypePassword,
    this.changePassword,
  });

  final TextEditingController? oldPassword;
  final TextEditingController? newPassword;
  final TextEditingController? reTypePassword;
  final VoidCallback? changePassword;

  final _formKey = GlobalKey<FormState>();

  final controller = Get.find<ChangePasswordController>();

  Widget buildChangePassword() {
    const title = 'Thay đổi mật khẩu';

    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(AppSizes.sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultLogo(),
            SizedBox(
              height: 10,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: oldPassword,
                style: GoogleFonts.beVietnam(),
                obscureText: controller.showOldPassword.value,
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
                      controller.toggleShowOldPassword();
                    },
                    icon: controller.showOldPassword.value
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                  hintText: 'Mật khẩu cũ',
                  hintStyle: kHintTextStyle,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: newPassword,
                    style: GoogleFonts.beVietnam(),
                    obscureText: controller.showNewPassword.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Mật khẩu mới không được bỏ trống';
                      }
                      if (!(value.length > 6)) {
                        return 'Mật khấu mới phải lớn hơn 6 kí tự';
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
                          controller.toggleShowNewPassword();
                        },
                        icon: controller.showNewPassword.value
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      hintText: 'Mật khẩu mới',
                      hintStyle: kHintTextStyle,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: reTypePassword,
                    style: GoogleFonts.beVietnam(),
                    obscureText: controller.showRetypePassword.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bạn phải nhập lại mật khẩu mới';
                      }
                      if (!(value.length > 6)) {
                        return 'Mật khấu phải lớn hơn 6 kí tự';
                      }
                      if (value != newPassword?.text) {
                        return 'Mật khẩu mới không khớp';
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
                          controller.toggleShowRetypePassword();
                        },
                        icon: controller.showRetypePassword.value
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      hintText: 'Nhập lại mật khẩu mới',
                      hintStyle: kHintTextStyle,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  changePassword!();
                }
              },
              child: DefaultBTN(
                btnText: 'Đổi mật khẩu ',
              ),
            ),
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
