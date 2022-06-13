import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/constant.dart';
import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';
import 'payment_cash_controller.dart';

class PaymentCashView extends GetView<PaymentCashController> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Thanh toán',
      body: SingleChildScrollView(
        child: Obx(() {
          return Form(
            key: controller.formKey,
            child: Container(
              margin: EdgeInsets.all(AppSizes.sidePadding),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      'Nhập địa chỉ giao hàng',
                      style: GoogleFonts.beVietnam(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
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
                            DropdownButtonFormField<String>(
                              style: GoogleFonts.beVietnam(),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.only(top: 14.0, left: 14),
                                hintText: 'Tất cả',
                                hintStyle:
                                    GoogleFonts.beVietnam(color: Colors.black),
                              ),
                              isExpanded: true,
                              value: controller.initialTinh.value,
                              icon: const Icon(Icons.arrow_drop_down),
                              validator: (value) {
                                if (value!.contains('Tất cả')) {
                                  return 'Vui lòng chọn Tỉnh/Thành phố';
                                }
                              },
                              focusColor: Colors.transparent,
                              items: controller.listProvinces.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.beVietnam(
                                        color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                controller.province.value = newValue!;
                                controller.findListDistricts(newValue);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DropdownButtonFormField<String>(
                              style: GoogleFonts.beVietnam(),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.only(top: 14.0, left: 14),
                                hintText: 'Tất cả',
                                hintStyle:
                                    GoogleFonts.beVietnam(color: Colors.black),
                              ),
                              isExpanded: true,
                              value: controller.initialHuyen.value,
                              icon: const Icon(Icons.arrow_drop_down),
                              validator: (value) {
                                if (value!.contains('Tất cả')) {
                                  return 'Vui lòng chọn Quận/Huyện';
                                }
                              },
                              focusColor: Colors.transparent,
                              items: controller.listDistricts.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.beVietnam(
                                        color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                controller.district.value = newValue!;
                                controller.findListWards(newValue);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DropdownButtonFormField<String>(
                              style: GoogleFonts.beVietnam(),
                              value: controller.initialXa.value,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.only(top: 14.0, left: 14),
                                hintText: 'Tất cả',
                                hintStyle:
                                    GoogleFonts.beVietnam(color: Colors.black),
                              ),
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down),
                              validator: (value) {
                                if (value!.contains('Tất cả')) {
                                  return 'Vui lòng chọn Phường/Xã';
                                }
                              },
                              focusColor: Colors.transparent,
                              items: controller.listWards.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.beVietnam(
                                        color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                controller.initialXa.value = newValue!;
                                controller.ward.value = newValue;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              autofillHints: const [AutofillHints.name],
                              style: GoogleFonts.beVietnam(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Số nhà không được bỏ trống';
                                }
                              },
                              onChanged: (newValue) {
                                controller.stNo.value = newValue;
                              },
                              decoration: InputDecoration(
                                hintText: 'Số nhà',
                                contentPadding:
                                    EdgeInsets.only(top: 14.0, left: 14),
                                hintStyle: kHintTextStyle,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              autofillHints: const [AutofillHints.name],
                              style: GoogleFonts.beVietnam(),
                              onChanged: (newValue) {
                                controller.note.value = newValue;
                              },
                              decoration: InputDecoration(
                                hintText: 'Ghi chú',
                                contentPadding:
                                    EdgeInsets.only(top: 14.0, left: 14),
                                hintStyle: kHintTextStyle,
                                border: OutlineInputBorder(),
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
                  SizedBox(
                    width: 350,
                    height: 45,
                    child: ElevatedButton(
                      child: controller.isLoadingPayment.value
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            )
                          : Text(
                              'Xác nhận',
                              style: GoogleFonts.beVietnam(
                                  fontSize: 18, color: Colors.white),
                            ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFFF8084)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                      onPressed: () => controller.payment(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
