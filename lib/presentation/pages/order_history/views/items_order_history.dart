import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/response/cart_response.dart';
import 'package:sajilo_dokan/domain/response/order_response.dart';
import 'package:sajilo_dokan/presentation/widgets/add_quantity.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';
import 'package:sajilo_dokan/utils/converter_currency.dart';

class ItemOrderHistory extends StatelessWidget {
  ItemOrderHistory({
    this.cartItem,
  });

  final OrderItem? cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
          ),
          top: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
    );
  }

  // 图片
  Widget _imageCartGoods() {
    return Container(
      height: 70,
      width: 70,
      alignment: Alignment.centerRight,
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
        ),
      ],
    );
  }

  // 商品价钱
  Widget _cartGoodsPrice(BuildContext context) {
    final priceTotal = (cartItem?.salePrice!)! * (cartItem?.quantity)!;
    return Column(
      children: <Widget>[
        Text('Tổng ${formatCurrency(priceTotal.toInt())}',
            style: GoogleFonts.beVietnam(fontSize: 15)),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
