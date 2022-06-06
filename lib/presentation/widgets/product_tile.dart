import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/domain/response/product.dart';
import 'package:sajilo_dokan/package/product_rating.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';
import 'package:sajilo_dokan/utils/converter_currency.dart';
import 'package:shimmer/shimmer.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({this.product, this.onTap});

  final Content? product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return product != null
        ? InkWell(
            onTap: () {
              Get.toNamed(Routes.productDetails, arguments: product);
            },
            child: SizedBox(
              width: 150,
              height: 250,
              child: Stack(
                children: [
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: product != null
                                  ? Center(
                                      child: Image.memory(
                                        base64.decode(product!.thumbnail!),
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.fill,
                                        errorBuilder: (_, __, ___) {
                                          return LoadingWidget();
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                        height: 170,
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.darkGray.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: 8),
                          if (product != null)
                            Text(
                              product!.name!,
                              maxLines: 2,
                              style: GoogleFonts.ptSans(),
                              overflow: TextOverflow.ellipsis,
                            )
                          else
                            Container(
                              height: 20,
                              width: 120,
                              decoration: BoxDecoration(
                                color: AppColors.darkGray.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                          if (product != null)
                            FittedBox(
                              child: Text(
                                'Giá ${formatCurrency(product!.price!.toInt())}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFF7643),
                                ),
                              ),
                            )
                          else
                            Container(
                              height: 15,
                              decoration: BoxDecoration(
                                color: AppColors.darkGray.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          SizedBox(height: 8),
                          if (product != null)
                            ProductRating(
                              rating: product?.ratingAverage ?? 0.0,
                              isReadOnly: true,
                              size: 15,
                              borderColor: Colors.red,
                              color: Colors.red,
                            )
                          else
                            Container(
                              height: 20,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.darkGray.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (product != null)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 20,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Text(
                            product!.price! <= 5000 ? 'New' : '-30%',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  else
                    SizedBox.shrink(),
                ],
              ),
            ),
          )
        : SizedBox(
            width: 150,
            height: 220,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[900]!,
              highlightColor: Colors.grey[800]!,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: AppColors.darkGray.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 10,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.darkGray.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 15,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.darkGray.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 10,
                      width: 110,
                      decoration: BoxDecoration(
                        color: AppColors.darkGray.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
