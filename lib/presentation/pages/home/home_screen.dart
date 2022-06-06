import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/home/views/header.dart';
import 'package:sajilo_dokan/presentation/pages/home/views/sajilo_carousel.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_controller.dart';
import 'package:sajilo_dokan/presentation/widgets/block_header.dart';
import 'package:sajilo_dokan/presentation/widgets/product_gridview_tile.dart';
import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';
import 'package:sajilo_dokan/presentation/widgets/shimmer_item.dart';

class Home extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final int? index;

  Home({this.index});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      bottomMenuIndex: index,
      hasLeadingIcon: false,
      title: 'Trang chủ',
      background: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              Header(),
              SajiloCarousel(),
              BlockHeader(
                title: 'Được đề xuất cho bạn',
                linkText: 'Xem tất cả',
                onLinkTap: () {
                  // final list = controller.productList
                  //     .where((i) => i.price! <= 5000)
                  //     .toList();
                  // navigator!.pushNamed(SajiloDokanRoutes.categoryProduct,
                  //     arguments: CategoryArguments(
                  //         product: list, categoryName: 'Popular Product'));
                },
              ),
              // Obx(() {
              //   final list = controller.productList
              //       .where((i) => i.price! <= 5000)
              //       .toList();
              //   return PopularProduct(
              //     products: controller.isLoading.value ? list : null,
              //   );
              // }),
              BlockHeader(
                title: 'Tất cả sản phẩm',
                linkText: '',
                onLinkTap: () {

                },
              ),
              Obx(() {
                if (!controller.isLoadingProduct.value) {
                     return
                       Column(
                         children: [
                           ProductGridviewTile(
                              productList:
                              controller.categoryProducts,
                            ),
                           if (controller.isLoadMoreProduct.value)
                             ...List.generate(
                               2,
                                   (index) => ShimmerItem(
                                 isGrid: true,
                               ),
                             )
                         ],
                       );
                } else {
                  return Column(
                    children: [
                        ...List.generate(
                          2,
                              (index) => ShimmerItem(
                            isGrid: true,
                          ),
                        )
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
