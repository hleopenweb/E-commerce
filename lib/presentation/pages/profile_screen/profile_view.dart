 import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';

import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';
import 'profile_controller.dart';
import 'widgets/display_image_widget.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Thông tin người dùng',
      body: Obx(() {
        return SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  DisplayImage(
                    imagePath: controller.user.value.profilePicture ?? '',
                    onPressed: () {},
                  ),
                  buildUserInfoDisplay(
                      UserModel().userName ?? '', 'Tên đăng nhập'),
                  buildUserInfoDisplay(controller.user.value.name ?? '', 'Họ và tên'),
                  buildUserInfoDisplay(
                    controller.user.value.phoneNumber ?? '',
                    'Số điện thoại',
                  ),
                  buildUserInfoDisplay(
                    controller.user.value.email ?? '',
                    'Email',
                  ),
                  buildUserInfoDisplay(
                    controller.user.value.address ?? '',
                    'Địa chỉ',
                  ),
                  buildUserInfoDisplay(
                    controller.user.value.gender == 0 ? 'Nam' : 'Nữ',
                    'Giới tính',
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.beVietnam(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
            width: 350,
            height: 40,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    getValue,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.beVietnam(
                      fontSize: 16,
                      height: 1.4,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ],
            ),
          )
        ],
      ));
}
