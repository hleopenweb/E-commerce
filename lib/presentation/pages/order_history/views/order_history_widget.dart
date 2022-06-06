import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/response/order_response.dart';
import 'package:sajilo_dokan/presentation/pages/order_history/order_controller.dart';
import 'package:sajilo_dokan/utils/convert_utils.dart';
import 'package:sajilo_dokan/utils/converter_currency.dart';

class OrderHistoryWidget extends StatelessWidget {
  final OrderContent item;

  OrderHistoryWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Ngày đặt hàng   ',
                      style: GoogleFonts.beVietnam(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: formatterFullDateTime(
                        item.createdDate!,
                      ),
                      style: GoogleFonts.beVietnam(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Trạng thái   ',
                          style: GoogleFonts.beVietnam(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: item.status?.status,
                          style: GoogleFonts.beVietnam(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: item.status?.color),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if(item.status == 'PENDING')
                    TextButton(
                      onPressed: ()=>Get.find<OrderController>().showDeleteOrderDialog(item),
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          'Hủy',
                          style: GoogleFonts.beVietnam(
                              fontSize: 12),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.grey,
                        side: BorderSide(color: Colors.grey),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                      ),
                    )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Tổng số tiền   ',
                      style: GoogleFonts.beVietnam(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: formatCurrency(item.totalCost!.toInt()),
                      style: GoogleFonts.beVietnam(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExt on String {
  String get status {
    switch (this) {
      case 'PENDING':
        return 'Đang chờ';
      case 'COMPLETED':
        return 'Hoàn thành';
      case 'REFUND':
        return 'Hoàn tiền';
      case 'CANCELLED':
        return 'Đã hủy';
      case 'PAID':
        return 'Đã thanh toán';
      case 'DECLINED':
        return 'Từ chối';
      default:
        return 'Đang chờ';
    }
  }

  Color get color {
    switch (this) {
      case 'PENDING':
        return Colors.grey;
      case 'COMPLETED':
        return Colors.green;
      case 'REFUND':
        return Colors.yellow;
      case 'CANCELLED':
        return Colors.red;
      case 'PAID':
        return Colors.blue;
      case 'DECLINED':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }
}
