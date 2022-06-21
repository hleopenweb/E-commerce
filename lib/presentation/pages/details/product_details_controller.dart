import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';
import 'package:sajilo_dokan/domain/request/comment_request.dart';
import 'package:sajilo_dokan/domain/request/feedback_request.dart';
import 'package:sajilo_dokan/domain/response/comment_response.dart';
import 'package:sajilo_dokan/domain/response/product.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_controller.dart';
import 'package:sajilo_dokan/presentation/pages/details/view/app_input_dialog.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class ProductDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  ProductDetailsController({
    required this.apiRepositoryInterface,
    required this.localRepositoryInterface,
    required this.userRepositoryInterface,
  });

  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  final UserRepositoryInterface userRepositoryInterface;

  RxInt selectedImage = 0.obs;
  RxInt count = 1.obs;

  final dataKey = GlobalKey();

  int get index => selectedImage.value;

  RxBool initbool = true.obs;
  RxInt productId = 0.obs;

  final Rx<CommentResponse> comments = CommentResponse().obs;
  RxBool isCommentsLoad = false.obs;
  RxBool isCommentsLoadMore = false.obs;
  final RxList<Comments> commentContent = RxList();
  final RxList<String> listUserComments = RxList();
  final TextEditingController textEditingController = TextEditingController();
  final content = Content().obs;
  late int args;
  final sort = 'ASC'.obs;
  final sortComment = 'DESC'.obs;
  final page = 0.obs;
  final _inputController = AppInputDialogController();

  PhotoViewScaleStateController? controllerState;

  //Animation Controller for Controll animation
  //Declare
  late AnimationController animationController;
  final isComment = false.obs;

  //Animation Onject
  Animation? colorAnimation;
  final Rx<Product> product = Product().obs;
  RxBool isLoading = true.obs;
  final RxList<Content> categoryProducts = RxList();
  RxBool isLoadingProduct = false.obs;
  RxBool isLoadingContent = false.obs;

  // We can detech the location of the card by this  GlobalKey<CartIconKey>
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  final cartQuantityItems = 1.obs;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      args = Get.arguments as int;
      await fetchContent(id: args).then((value) {
        gkCart.currentState!.runCartAnimation(
            (Get.find<CartController>().contentCartList.length).toString());
        getComments(
          page: page.value,
          limit: 3,
          sort: 'id,$sortComment',
          productId: content.value.id,
          isLoadComment: false,
        );
        fetchProduct();
      });
    }

    //Initialize Animation Controller
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(animationController);
    animationController.forward();
    animationController.addListener(() => print(animationController.value));
    controllerState = PhotoViewScaleStateController();
    super.onInit();
  }

  Future<void> loadCategoryProducts({
    int? limit,
    int? page,
    String? sort,
    String? productName,
    int? categoryId,
  }) async {
    try {
      isLoadingProduct(true);
      product.value = (await apiRepositoryInterface.getCategoryProduct(
            limit,
            page,
            sort,
            productName,
            categoryId,
          )) ??
          Product();
      if (product.value.content!.isNotEmpty) {
        product.value.content?.forEach((element) {
          categoryProducts.addIf(
              element.categoryId == content.value.categoryId, element);
        });
      }
    } catch (e) {
      isLoadingProduct(false);
      rethrow;
    } finally {
      isLoadingProduct(false);
    }
  }

  Future<void> fetchContent({
    int? id,
  }) async {
    isLoadingContent(true);
    try {
      isLoadingContent(true);
      content.value =
          (await apiRepositoryInterface.getProductDetail(id!)) ?? Content();
    } catch (e) {
      isLoadingContent(false);
      rethrow;
    } finally {
      isLoadingContent(false);
    }
  }

  Future<void> fetchProduct() async {
    categoryProducts.clear();
    await loadCategoryProducts(
      page: 0,
      limit: 10,
      sort: 'price,ASC',
    );
  }

  Future<void> feedback(
      Content item, double rating, BuildContext context) async {
    final res = await apiRepositoryInterface.feedback(
      FeedbackRequest(
        customerId: UserModel().id!,
        rating: rating,
        productId: item.id!,
      ),
    );
    if (res != null) {
      _handleSuccess(context);
    } else {
      _handleFailed(context);
    }
  }

  Future<void> _handleFailed(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'Đánh giá thất bại',
            style: GoogleFonts.beVietnam(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Vui lòng mua sản phẩm để đánh giá',
            style: GoogleFonts.beVietnam(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                'Hủy',
                style: GoogleFonts.beVietnam(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () async {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSuccess(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'Bạn đã đánh giá thành công',
            style: GoogleFonts.beVietnam(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Cảm ơn vì đã dành thời gian để chúng tôi hoàn thiện sản phẩm',
            style: GoogleFonts.beVietnam(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                'Hủy',
                style: GoogleFonts.beVietnam(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                Get.back();
                await fetchContent(id: args);
              },
            ),
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () async {
                Get.back();
                await fetchContent(id: args);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  Future<String> getUserInfo(int id) async {
    try {
      final userResponse = await userRepositoryInterface.getUserFromId(id);
      if (userResponse != null) {
        return userResponse.userName ?? '';
      }
    } catch (e) {
      rethrow;
    }
    return '';
  }

  void goBack() {
    controllerState!.scaleState = PhotoViewScaleState.initial;
  }

  void setInit(bool? fab) {
    initbool(fab);
  }

  void clickFavorite() {
    initbool(!initbool.value);
  }

  Future<void> makeFavorite(int? id) async {
    final user = await localRepositoryInterface.getUser();
    final token = user?.accessToken;
    clickFavorite();
    if (token != null) {
      var result = await apiRepositoryInterface.makeFavorite(token, id);
      print('fab btn called');

      if (result == true) {
        Get.snackbar(
          initbool.value
              ? 'Add item to favorit list successfully!'
              : 'Remove from favorite',
          '',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          borderRadius: 0,
          backgroundColor: Colors.black.withOpacity(0.8),
          isDismissible: true,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(5),
          animationDuration: Duration(seconds: 1),
          duration: Duration(seconds: 2),
        );
      }
    } else {
      Get.offNamed(Routes.login);
    }
  }

  Future<void> getComments(
      {int? limit,
      int? page,
      String? sort,
      int? productId,
      required bool isLoadComment}) async {
    try {
      isLoadComment ? isCommentsLoadMore(true) : isCommentsLoad(true);
      comments.value = (await apiRepositoryInterface.getCommentProduct(
            limit,
            page,
            sort,
            productId,
          )) ??
          CommentResponse();

      final list = comments.value.content;
      if (list != null && list.isNotEmpty) {
        for (final comment in list) {
          final user = await getUserInfo(comment.customerId ?? 1);
          listUserComments.add(user);
        }
        commentContent.addAll(list);
      }

      print(commentContent.length);
    } catch (e) {
      isLoadComment ? isCommentsLoadMore(false) : isCommentsLoad(false);
      rethrow;
    } finally {
      isLoadComment ? isCommentsLoadMore(false) : isCommentsLoad(false);
    }
  }

  Future<void> writeComment(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final comment = textEditingController.text;
    textEditingController.clear();
    try {
      isCommentsLoad(true);
      await apiRepositoryInterface.createComment(
        CommentRequest(
            comment: comment,
            productId: content.value.id,
            customerId: UserModel().id),
      );
      commentContent.clear();
      listUserComments.clear();
      page.value = 0;
      await getComments(
        page: page.value,
        limit: 3,
        sort: 'id,$sortComment',
        productId: content.value.id,
        isLoadComment: false,
      );
      isCommentsLoad(false);
    } on Exception {
      isCommentsLoad(false);
      rethrow;
    }
  }

  void likeBtn(int? commentId, int? productId) async {
    final user = await localRepositoryInterface.getUser();
    final token = user?.accessToken;
    if (token != null) {
      var result = await apiRepositoryInterface.likeComment(token, commentId);

      if (result == true) {
        // await getComments(productId, token);
      }
    } else {
      Get.offNamed(Routes.login);
    }
  }

  void dislikeBtn(int? commentId, int? productId) async {
    final user = await localRepositoryInterface.getUser();
    final token = user?.accessToken;
    if (token != null) {
      var result =
          await apiRepositoryInterface.dislikeComment(token, commentId);

      if (result == true) {
        //     await getComments(productId, token);
      }
    } else {
      Get.offNamed(Routes.login);
    }
  }

// Improvement/Suggestion 4.4 -> Running AddTOCartAnimation BEFORE runCArtAnimation
  Future<void> listClick(GlobalKey gkImageContainer) async {
    if (count.value > 0) {
      await Get.find<CartController>().addToCart(
          content.value.id, count.value, content.value.price!.toInt());
      await runAddToCardAnimation(gkImageContainer);
      await gkCart.currentState!.runCartAnimation(
          (Get.find<CartController>().contentCartList.length).toString());
    } else {
      Get.snackbar(
        'Lỗi thêm giỏ hàng',
        'Vui lòng nhập số lượng ',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        borderRadius: 0,
        backgroundColor: Colors.black.withOpacity(0.8),
        isDismissible: true,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(15),
        animationDuration: Duration(seconds: 1),
        duration: Duration(seconds: 2),
      );
    }
  }

  void onFeedback(BuildContext context) {
    AppInputDialog.showInputDialog(
      controller: _inputController,
      subTitle: 'Để lại đánh giá để chúng tôi ngày càng hoàn thiện',
      title: 'Đánh giá sản phẩm',
      submitButtonTitle: 'Đánh giá',
      placeHolder: '',
      onSubmit: (rating) async {
        await feedback(content.value, rating, context);
      },
      maxLength: 255,
    );
  }
}
