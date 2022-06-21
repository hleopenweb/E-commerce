import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sajilo_dokan/config/colors.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_controller.dart';
import 'package:sajilo_dokan/presentation/pages/login/views/social_button.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/default_btn.dart';
import 'package:sajilo_dokan/presentation/widgets/default_logo.dart';
import 'package:sajilo_dokan/utils/convert_utils.dart';

import '../../../../constant.dart';

class SignForm extends StatelessWidget {
  SignForm(
      {this.name,
      this.email,
      this.password,
      this.logOrRegAction,
      this.userName,
      this.phone});

  void create() {
    Get.snackbar('Lỗi xác thực', 'Vui lòng kiểm tra lại thông tin!',
        snackStyle: SnackStyle.FLOATING);
  }

  final TextEditingController? name;
  final TextEditingController? email;
  final TextEditingController? password;
  final TextEditingController? userName;
  final TextEditingController? phone;
  final VoidCallback? logOrRegAction;

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

  final googlesignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  Future<void> fblogin() async {
    final result = await FacebookAuth.instance.login(permissions: [
      'public_profile',
      'email',
    ]);
    if (result.status == LoginStatus.success) {
      log(result.accessToken!.token);
      socialLogin(result.accessToken!.token, 'facebook');
    } else {
      return;
    }
  }

  Future<void> login() async {
    await googlesignIn
        .signIn()
        .then((result) => result!.authentication)
        .then((googleKey) => socialLogin(googleKey.idToken, 'google'))
        .catchError((err) => null);
  }

  Widget buildSignType() {
    final title = controller.isSignIn.value ? 'Chào mừng bạn' : 'Tạo tài khoản';
    final primary = controller.isSignIn.value
        ? 'Vui lòng đăng nhập để tiếp tục'
        : 'Đăng kí mới';

    final btnText = controller.isSignIn.value ? 'Đăng nhập' : 'Đăng kí';
    final secondary = controller.isSignIn.value
        ? 'Bạn chưa có tài khoản ? '
        : 'Đã có tài khoản ? ';

    final signInOrRegister =
        controller.isSignIn.value ? 'Đăng kí' : 'Đăng nhập';

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
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    primary,
                    style: GoogleFonts.beVietnam(
                      textStyle: TextStyle(fontSize: 16),
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
                      if (!controller.isSignIn.value) ...[
                        TextFormField(
                          controller: name,
                          autofillHints: const [AutofillHints.name],
                          style: GoogleFonts.beVietnam(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Họ và tên không được bỏ trống';
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Họ và tên ',
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: Colors.black38,
                              ),
                              hintStyle: kHintTextStyle,
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.beVietnam(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email không được bỏ trống';
                            }
                            if (!value.contains('@')) {
                              return 'Email không hợp lệ';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black38,
                            ),
                            hintText: 'Email',
                            hintStyle: kHintTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          style: GoogleFonts.beVietnam(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Số điện thoại không được bỏ trống';
                            } else if (value.length < 10) {
                              return 'Số điện thoại phải đủ 10 số';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.black38,
                            ),
                            hintText: 'Số điện thoại',
                            hintStyle: kHintTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          style: GoogleFonts.beVietnam(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.transgender,
                              color: Colors.black38,
                            ),
                            hintText: 'Nam',
                            hintStyle: kHintTextStyle,
                          ),
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          validator: (value) {},
                          focusColor: Colors.transparent,
                          items: listGenders.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style:
                                    GoogleFonts.beVietnam(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            switch (newValue) {
                              case 'Nam':
                                controller.gender.value = 0;
                                break;
                              case 'Nữ':
                                controller.gender.value = 1;
                                break;
                              default:
                                controller.gender.value = 2;
                                break;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                      TextFormField(
                        controller: userName,
                        keyboardType: TextInputType.name,
                        style: GoogleFonts.beVietnam(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tên đăng nhập không được bỏ trống';
                          } else if (hasWhiteSpace(value)) {
                            return 'Tên đăng nhập không được có khoảng trống';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.supervisor_account_sharp,
                            color: Colors.black38,
                          ),
                          hintText: 'Tên đăng nhập',
                          hintStyle: kHintTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                      if (controller.isSignIn.value)
                        InkWell(
                          onTap: () {
                            //navigator!.pushNamed(Routes.checkAccount);
                          },
                          child: Text(
                            'Quên mật khẩu',
                            style: GoogleFonts.beVietnam(),
                          ),
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
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  logOrRegAction!();
                } else {
                  create();
                }
              },
              child: DefaultBTN(
                btnText: btnText,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: Text('Hoặc đăng nhập bằng ',
                    style: GoogleFonts.beVietnam())),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(
                    imageName: 'assets/images/search.png',
                    socialMedia: 'Google',
                    color: Colors.redAccent,
                    onPressed: login,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SocialButton(
                    imageName: 'assets/images/facebook.png',
                    socialMedia: 'Facebook',
                    color: Colors.blue,
                    onPressed: fblogin,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(child: Text('___________')),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(secondary, style: GoogleFonts.beVietnam()),
                InkWell(
                  onTap: () {
                    controller.toggleFormType();
                  },
                  child: Text(
                    signInOrRegister,
                    style: GoogleFonts.beVietnam(
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return buildSignType();
    });
  }
}
