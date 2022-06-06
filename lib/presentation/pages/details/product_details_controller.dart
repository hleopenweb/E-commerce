import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';
import 'package:sajilo_dokan/domain/request/comment_request.dart';
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
  RxInt count = 0.obs;

  final dataKey = GlobalKey();

  int get index => selectedImage.value;

  RxBool initbool = true.obs;
  RxInt productId = 0.obs;

  final Rx<CommentResponse> comments = CommentResponse().obs;
  RxBool isCommentsLoad = false.obs;
  final RxList<Comments> commentContent = RxList();
  final RxList<String> listUserComments = RxList();
  late final TextEditingController textEditingController;
  late Content args;
  final sort = 'ASC'.obs;
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

  // We can detech the location of the card by this  GlobalKey<CartIconKey>
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  final cartQuantityItems = 0.obs;

  @override
  Future<void> onInit() async {
    //Initialize Animation Controller
    textEditingController = TextEditingController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(animationController);
    animationController.forward();
    animationController.addListener(() => print(animationController.value));
    if (Get.arguments != null) {
      args = Get.arguments as Content;
    }
    controllerState = PhotoViewScaleStateController();
    await getComments(
      page: page.value,
      limit: 3,
      sort: 'id,$sort',
      productId: args.id,
    );
    await fetchProduct();
    await gkCart.currentState!.runCartAnimation(
        (Get.find<CartController>().contentCartList.length).toString());

    super.onInit();
  }

  Future<void> fetchProduct() async {
    categoryProducts.clear();
    await loadCategoryProducts(
      page: 0,
      limit: 10,
      sort: 'price,ASC',
    );
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
              element.categoryId == args.categoryId, element);
        });
      }
    } catch (e) {
      isLoadingProduct(false);
      rethrow;
    } finally {
      isLoadingProduct(false);
    }
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

  Future<void> getComments({
    int? limit,
    int? page,
    String? sort,
    int? productId,
  }) async {
    try {
      isCommentsLoad(true);
      comments.value = (await apiRepositoryInterface.getCommentProduct(
            limit,
            page,
            sort,
            productId,
          )) ??
          CommentResponse();
      if (comments.value.content!.isNotEmpty) {
        commentContent.addAll(comments.value.content!);
      }
      for (final comment in commentContent) {
        listUserComments.add(await getUserInfo(comment.customerId!));
      }
      print(commentContent.length);
    } catch (e) {
      isCommentsLoad(false);
      rethrow;
    } finally {
      isCommentsLoad(false);
    }
  }

  Future<void> writeComment() async {
    final comment = textEditingController.text;
    textEditingController.clear();
    try {
      isCommentsLoad(true);
      await apiRepositoryInterface.createComment(
        CommentRequest(
            comment: comment, productId: args.id, customerId: UserModel().id),
      );
      page.value = 0;
      listUserComments.clear();
      commentContent.clear();
      await getComments(
        page: page.value,
        limit: 3,
        sort: 'id,$sort',
        productId: args.id,
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
          args.id, count.value, args.price!.toInt());
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

  void onFeedback() {
    AppInputDialog.showInputDialog(
      controller: _inputController,
      subTitle:
      'test',
      title:'test',
      placeHolder: 'test',
      submitButtonTitle: 'test',
      onSubmit: (text) async {
      },
      confirmButtonValidator: (text) => text.isNotEmpty,
      maxLength: 255,
    );
  }
}
