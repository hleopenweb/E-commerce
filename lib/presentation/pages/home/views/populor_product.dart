import 'package:flutter/material.dart';
import 'package:sajilo_dokan/domain/response/product.dart';
import 'package:sajilo_dokan/presentation/widgets/product_tile.dart';
class PopularProduct extends StatelessWidget {
  const PopularProduct({this.products});
  final List<Content>? products;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(products != null ? products!.length : 3, (index) {
            return ProductTile(
                product: products != null ? products![index] : null);
          })
        ],
      ),
    );
  }
}
