import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/config/text_theme.dart';
import 'package:sajilo_dokan/presentation/pages/Category/product/controller/products_controller.dart';
import 'package:sajilo_dokan/presentation/widgets/product_gridview_tile.dart';
import 'package:sajilo_dokan/presentation/widgets/product_list_tile.dart';
import 'package:sajilo_dokan/presentation/widgets/shimmer_item.dart';

class CategoryProducts extends GetWidget<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 72,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back),
                          iconSize: 28,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        Container(
                          height: 42,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: controller.textEditingController,
                            onSubmitted: (value) {
                              controller.search.value = value;
                              controller.searchProduct();
                            },
                            style: kDefaultInput,
                            decoration: InputDecoration(
                              hintText: controller.args.name,
                              prefixIcon: Icon(
                                Icons.search,
                                size: 24,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                        ),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 6),
                              width: MediaQuery.of(context).size.width * 0.21,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.filter_alt_outlined,
                                      color: Colors.grey,
                                    ),
                                    Spacer(),
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Lọc',
                                        style: kDefaultInput.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                controller.sort.value == 'ASC'
                                    ? controller.sort.value = 'DESC'
                                    : controller.sort.value = 'ASC';
                                controller.searchProduct();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 6),
                                width: MediaQuery.of(context).size.width * 0.21,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        controller.sort.value == 'ASC'
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,
                                        color: Colors.redAccent,
                                      ),
                                      Spacer(),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          'Giá',
                                          style: kDefaultInput.copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                controller.changeGridMode(
                                  controller.isGrid.value,
                                );
                              },
                              icon: !controller.isGrid.value
                                  ? Icon(Icons.grid_view)
                                  : Icon(Icons.format_list_bulleted),
                            )
                          ],
                        ),
                      ),
                      Obx(() {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: controller.categoryProducts.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.textEditingController
                                              .clear();
                                          if (!controller.isChooseAll.value) {
                                            controller.isChooseAll.toggle();
                                            controller.search.value = '';
                                            controller.searchProduct();
                                          }
                                        },
                                        child: Container(
                                          height: 45,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: controller.isChooseAll.value
                                                ? Colors.redAccent
                                                : Colors.black,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'All',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ...List.generate(
                                        controller.brandProducts.length,
                                        (index) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: InkWell(
                                            onTap: () {
                                              controller.textEditingController
                                                  .clear();
                                              if (controller
                                                  .isChooseAll.value) {
                                                controller.isChooseAll.toggle();
                                              }
                                              controller.search.value =
                                                  controller.brandProducts
                                                      .elementAt(index)
                                                      .brand!;
                                              controller.searchProduct();
                                            },
                                            child: Container(
                                              height: 45,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: controller.brandProducts
                                                        .elementAt(index)
                                                        .isChoose!
                                                        .value
                                                    ? Colors.redAccent
                                                    : Colors.black,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    controller.brandProducts
                                                        .elementAt(index)
                                                        .brand!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                        );
                      }),
                      Obx(() {
                        if (!controller.isLoadingProduct.value) {
                          return !controller.isGrid.value
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Column(
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
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                        controller.categoryProducts.length,
                                        (index) => ProductListTile(
                                          product: controller
                                              .categoryProducts[index],
                                        ),
                                      ),
                                      if (controller.isLoadMoreProduct.value)
                                        ...List.generate(
                                          4,
                                          (index) => ShimmerItem(
                                            isGrid: false,
                                          ),
                                        )
                                    ],
                                  ),
                                );
                        } else {
                          return Column(
                            children: [
                              if (!controller.isGrid.value)
                                ...List.generate(
                                  2,
                                  (index) => ShimmerItem(
                                    isGrid: true,
                                  ),
                                )
                              else
                                ...List.generate(
                                  4,
                                  (index) => ShimmerItem(
                                    isGrid: false,
                                  ),
                                )
                            ],
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ]),
            )
          ],
        );
      }),
    );
  }
}
