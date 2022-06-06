import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/domain/response/product.dart';
import 'package:sajilo_dokan/package/product_rating.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/utils/converter_currency.dart';

import 'loading_view.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({this.product});

  final Content? product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.productDetails, arguments: product),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Stack(
          children: [
            Card(
              elevation: 2,
              child: Row(
                children: [
                  SizedBox(
                    height: 200,
                    width: 150,
                    child: Center(
                      child: Image.memory(
                        base64.decode(product!.thumbnail!),
                        height: 150,
                        width: 130,
                        fit: BoxFit.fill,
                        errorBuilder: (_, __, ___) {
                          return LoadingWidget();
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product!.name!,
                            maxLines: 2,
                            style: GoogleFonts.ptSans(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              ProductRating(
                                rating: product?.ratingAverage ?? 0.0,
                                isReadOnly: true,
                                size: 15,
                                borderColor: Colors.red,
                                color: Colors.red,
                              ),
                              Text(
                                '4',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Giá ${formatCurrency(product!.price!.toInt())}',
                            style: TextStyle(color: Colors.redAccent),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.red),
                child: Center(
                  child: Text(
                    product!.price! <= 30 ? 'Mới' : '-30%',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
