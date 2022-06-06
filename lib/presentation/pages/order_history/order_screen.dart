import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/response/order_response.dart';
import 'package:sajilo_dokan/presentation/pages/order_history/order_controller.dart';
import 'package:sajilo_dokan/presentation/pages/order_history/views/order_history_widget.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';
import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';

import 'views/items_order_history.dart';

class OrderScreen extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return MyScaffold(
        title: 'Đơn hàng đã đặt',
        body: SingleChildScrollView(
          child: !controller.isOrderLoad.value
              ? Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ExpansionPanelList(
                      animationDuration: Duration(
                        milliseconds: 1000,
                      ),
                      expansionCallback: (int index, bool isExpanded) {
                        controller.contentOrderList[index].isExpanded.toggle();
                      },
                      children:
                          controller.contentOrderList.map((OrderContent item) {
                        return ExpansionPanel(
                          canTapOnHeader: true,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return OrderHistoryWidget(
                              item: item,
                            );
                          },
                          body: item.cartItems == null ||
                                  item.cartItems!.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('Không có dữ liệu',
                                      style:
                                          GoogleFonts.beVietnam(fontSize: 15)),
                                )
                              : Column(
                                  children: item.cartItems!
                                      .map(
                                        (e) => ItemOrderHistory(
                                          cartItem: e,
                                        ),
                                      )
                                      .toList(),
                                ),
                          isExpanded: item.isExpanded.value,
                        );
                      }).toList(),
                    ),
                  ],
                )
              : Container(
                  margin: EdgeInsets.only(top: Get.width / 2 + 100),
                  child: Center(child: LoadingWidget()),
                ),
        ),
      );
    });
  }
}
