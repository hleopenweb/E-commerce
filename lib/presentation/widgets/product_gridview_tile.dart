import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sajilo_dokan/domain/response/product.dart';
import 'package:sajilo_dokan/presentation/widgets/product_tile.dart';

class ProductGridviewTile extends StatelessWidget {
  const ProductGridviewTile({this.productList});
  final List<Content>? productList;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 5, right: 5,top:10),
        shrinkWrap: true,
        primary: false,
        crossAxisCount: 2,
        itemCount: productList != null ? productList!.length : 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) => ProductTile(
              product: productList != null ? productList![index] : null,
            ),
        staggeredTileBuilder: (index) => StaggeredTile.fit(1));
  }
}
