import 'dart:convert';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sajilo_dokan/config/colors.dart';
import 'package:sajilo_dokan/domain/response/product.dart';
import 'package:sajilo_dokan/package/product_rating.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_controller.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_controller.dart';
import 'package:sajilo_dokan/presentation/pages/details/view/add_cart.dart';
import 'package:sajilo_dokan/presentation/pages/details/view/image_screen.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/add_quantity.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';
import 'package:sajilo_dokan/presentation/widgets/product_tile.dart';
import 'package:sajilo_dokan/presentation/widgets/shimmer_item.dart';
import 'package:sajilo_dokan/utils/convert_utils.dart';
import 'package:sajilo_dokan/utils/converter_currency.dart';
import 'package:share/share.dart';

import '../../../constant.dart';

class ProductDetailsScreen extends GetWidget<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      gkCart: controller.gkCart,
      rotation: true,
      initiaJump: false,
      receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
        // You can run the animation by addToCardAnimationMethod, just pass trough the the global key of  the image as parameter
        controller.runAddToCardAnimation = addToCardAnimationMethod;
      },
      child: Obx(() {
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: 28,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.cart);
                        Get.find<CartController>().hasLeadingIcon.value = true;
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: AddToCartIcon(
                          key: controller.gkCart,
                          icon: Icon(Icons.shopping_cart),
                          colorBadge: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    )
                  ],
                  expandedHeight: 300,
                  pinned: true,
                  elevation: 2,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    background: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        Hero(
                          tag: controller.content.value.thumbnail ?? '',
                          child: InkWell(
                            onDoubleTap: () {
                              navigator!.pushNamed(
                                Routes.imageScreen,
                                arguments: ImageScreenArguments(
                                  product: controller.content.value,
                                ),
                              );
                            },
                            child: PhotoViewGallery.builder(
                              scrollPhysics: const BouncingScrollPhysics(),
                              builder: (BuildContext context, int index) {
                                return PhotoViewGalleryPageOptions(
                                  disableGestures: true,
                                  imageProvider: MemoryImage(
                                    base64.decode(
                                      controller.content.value.thumbnail ?? '',
                                    ),
                                  ),
                                  initialScale:
                                      PhotoViewComputedScale.contained * 0.8,
                                );
                              },
                              itemCount: 1,
                              loadingBuilder: (context, progress) => Center(
                                child: SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    value: progress == null
                                        ? null
                                        : progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes!,
                                  ),
                                ),
                              ),
                              backgroundDecoration:
                                  BoxDecoration(color: Colors.white),
                              onPageChanged: (int index) {
                                controller.selectedImage(index);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Giá ${formatCurrency((controller.content.value.price ?? 0).toInt())}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      Obx(() {
                                        return Row(
                                          children: [
                                            AnimatedContainer(
                                              duration:
                                                  Duration(microseconds: 500),
                                              child: IconButton(
                                                onPressed: () {
                                                  controller.makeFavorite(
                                                    controller.content.value.id,
                                                  );
                                                },
                                                icon: controller.initbool.value
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                        size: 30,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border,
                                                      ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Share.share(
                                                    'App link not available');
                                              },
                                              icon: Icon(Icons.share),
                                            ),
                                          ],
                                        );
                                      })
                                    ],
                                  ),
                                  Text(
                                    controller.content.value.name ?? '',
                                    style: GoogleFonts.ptSans(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () => Scrollable.ensureVisible(
                                          controller.dataKey.currentContext!,
                                        ),
                                        child: Row(
                                          children: [
                                            ProductRating(
                                              rating: controller.content.value
                                                      .ratingAverage ??
                                                  0.0,
                                              isReadOnly: true,
                                              size: 15,
                                              borderColor:
                                                  Colors.red.withOpacity(0.8),
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              controller.comments.value
                                                          .totalElements !=
                                                      null
                                                  ? controller.comments.value
                                                      .totalElements
                                                      .toString()
                                                  : '',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Text(
                                              ' nhận xét',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Người bán:',
                                          style: TextStyle(color: Colors.black),
                                          children: const [
                                            TextSpan(
                                              text: ' Phạm Như Hòa',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            controller.onFeedback(context),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 7),
                                            child: Text(
                                              'Đánh giá',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 150,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Đổi trả và hoàn tiền dễ dàng trong vòng 7 ngày ',
                                    style: GoogleFonts.beVietnam(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Bạn có thể dễ dàng đổi trả sản phẩm trong vòng 7 ngày với các lí do như hư hại , hết hàng ,đơn hàng khác với mô tả , vv ...',
                                    style: GoogleFonts.beVietnam(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.only(left: 8),
                              expandedAlignment: Alignment.topLeft,
                              title: Text(
                                'Mô tả sản phẩm ',
                                style: GoogleFonts.beVietnam(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 20),
                                  child: Text(
                                    controller.content.value.description ?? '',
                                    style: GoogleFonts.beVietnam(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Số lượng',
                                    style: GoogleFonts.beVietnam(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Obx(() {
                                    return AddQuantity(
                                      noOfItem: controller.count.value,
                                      addButton: () => controller.count.value++,
                                      subtractButton: () =>
                                          controller.count.value--,
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            if (!controller.isCommentsLoad.value) {
                              return Container(
                                color: Colors.white,
                                key: controller.dataKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Đánh giá & nhận xét (${controller.comments.value.totalElements ?? 0})',
                                            style: GoogleFonts.beVietnam(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              controller.page.value += 1;
                                              await controller.getComments(
                                                page: controller.page.value,
                                                limit: 3,
                                                sort:
                                                    'id,${controller.sort.value}',
                                                productId:
                                                    controller.content.value.id,
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Xem thêm bình luận',
                                                  style: GoogleFonts.beVietnam(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    ...List.generate(
                                        controller.commentContent.length,
                                        (index) => !controller
                                                .isCommentsLoad.value
                                            ? Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            controller
                                                                    .listUserComments[
                                                                index],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          Spacer(),
                                                          ProductRating(
                                                            rating: controller
                                                                    .content
                                                                    .value
                                                                    .ratingAverage ??
                                                                0.0,
                                                            isReadOnly: true,
                                                            size: 12,
                                                            borderColor: Colors
                                                                .red
                                                                .withOpacity(
                                                                    0.8),
                                                            color: Colors.red,
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            controller
                                                                .commentContent[
                                                                    index]
                                                                .comment!,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            formatterFullDate(
                                                                controller
                                                                    .commentContent[
                                                                        index]
                                                                    .createdDate!),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons
                                                                  .thumb_up_alt_outlined,
                                                              size: 12,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .likeBtn(
                                                                controller
                                                                    .commentContent[
                                                                        index]
                                                                    .id,
                                                                controller
                                                                    .content
                                                                    .value
                                                                    .id,
                                                              );
                                                            },
                                                          ),
                                                          Text(
                                                            '7',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                elevation: 0.5,
                                              )
                                            : LoadingWidget())
                                  ],
                                ),
                              );
                            } else {
                              return LoadingWidget();
                            }
                          }),
                          SizedBox(height: 15),
                          Obx(() {
                            return Stack(
                              children: [
                                AnimatedOpacity(
                                  duration: Duration(milliseconds: 200),
                                  opacity: controller.isComment.value ? 1 : 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Visibility(
                                      visible: controller.isComment.value,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: controller
                                                  .textEditingController,
                                              autofillHints: const [
                                                AutofillHints.name
                                              ],
                                              style: GoogleFonts.beVietnam(),
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      Colors.blueGrey[50],
                                                  hintText: 'Viết bình luận',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 18.0,
                                                          vertical: 4),
                                                  hintStyle: kHintTextStyle,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    borderSide: BorderSide.none,
                                                  )),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await controller.writeComment();
                                              controller.isComment.toggle();
                                            },
                                            icon: Icon(
                                              Icons.send,
                                              size: 28,
                                            ),
                                            color: Colors.blue[500],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                AnimatedOpacity(
                                  opacity: controller.isComment.value ? 0 : 1,
                                  duration: Duration(milliseconds: 200),
                                  child: Visibility(
                                    visible: !controller.isComment.value,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      width: Get.width,
                                      height: 50,
                                      child: ElevatedButton(
                                          child: Text('Viết bình luận',
                                              style: GoogleFonts.beVietnam(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blue),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                side: BorderSide(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                          onPressed: () =>
                                              controller.isComment.toggle()),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                          SizedBox(height: 15),
                          Divider(
                              height: 5,
                              thickness: 6,
                              color: kDividerColor.withOpacity(0.2)),
                          SizedBox(height: 15),
                          Container(
                            alignment: Alignment.centerLeft,
                            color: Colors.white.withOpacity(0.4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Sản phẩm tương tự',
                                style: GoogleFonts.beVietnam(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Obx(() {
                            if (!controller.isLoadingProduct.value) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Row(
                                    children: controller.categoryProducts
                                        .map(
                                          (element) => ProductTile(
                                            product: element,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              );
                            } else {
                              return ShimmerItem(
                                isGrid: true,
                                itemCount: 2,
                              );
                            }
                          }),
                          SizedBox(height: 30),
                        ],
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
          bottomNavigationBar: AddToCard(
            product: controller.content.value,
            imageLink: controller.content.value.thumbnail ?? '',
            onClick: controller.listClick,
          ),
        );
      }),
    );
  }
}

class ProductDetailsArguments {
  ProductDetailsArguments({this.product});

  final Content? product;
}
