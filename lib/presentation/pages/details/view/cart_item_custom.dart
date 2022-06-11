import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/response/cart_response.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_controller.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/add_quantity.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';
import 'package:sajilo_dokan/utils/converter_currency.dart';

class CartItemCustom extends StatelessWidget {
  CartItemCustom({this.cartItem, this.add, this.sub, required this.onChanged});

  final ContentCart? cartItem;
  final VoidCallback? add;
  final VoidCallback? sub;
  void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.productDetails, arguments: cartItem?.productId);
        Get.find<CartController>().hasLeadingIcon.value = false;
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Flexible(child: _checkBoxCartGoods(context)),
            Flexible(flex: 2, child: _imageCartGoods()),
            SizedBox(
              width: 40,
            ),
            Flexible(
              child: _cartGoodsNameCount(context),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }

  // 复选框
  Widget _checkBoxCartGoods(BuildContext context) {
    return Checkbox(
      value: cartItem?.isCheck.value,
      onChanged: (value) {
        onChanged.call(value ?? false);
      },
      checkColor: Colors.white,
      activeColor: Colors.pink,
    );
  }

  // 图片
  Widget _imageCartGoods() {
    return SizedBox(
      height: 100,
      width: 100,
      child: Image.memory(
        base64.decode(cartItem?.productThumbnail ?? ''),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return LoadingWidget();
        },
      ),
    );
  }

  // 商品名称
  Widget _cartGoodsNameCount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AutoSizeText(
          cartItem?.productName ?? '',
          style: GoogleFonts.beVietnam(fontSize: 14),
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          softWrap: true,
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10,
        ),
        _cartGoodsPrice(context),
        AddQuantity(
          noOfItem: cartItem?.quantity ?? 0,
          addButton: add,
          subtractButton: sub,
        ),
      ],
    );
  }

  // 商品价钱
  Widget _cartGoodsPrice(BuildContext context) {
    final priceTotal = (cartItem?.salePrice!)! * (cartItem?.quantity)!;
    return Column(
      children: <Widget>[
        Text('Giá ${formatCurrency(priceTotal.toInt())}',
            style: GoogleFonts.beVietnam(fontSize: 15)),
        SizedBox(
          height: 15,
        ),
        //   showDeleteDialog(context);
      ],
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('删除提示'),
          content: Text('Ten gi do'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
