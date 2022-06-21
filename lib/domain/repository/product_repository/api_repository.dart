import 'package:sajilo_dokan/domain/model/product_comment.dart';
import 'package:sajilo_dokan/domain/request/add_cart_request.dart';
import 'package:sajilo_dokan/domain/request/add_order_request.dart';
import 'package:sajilo_dokan/domain/request/cancel_order_request.dart';
import 'package:sajilo_dokan/domain/request/comment_request.dart';
import 'package:sajilo_dokan/domain/request/feedback_request.dart';
import 'package:sajilo_dokan/domain/request/new_password_request.dart';
import 'package:sajilo_dokan/domain/response/add_cart_response.dart';
import 'package:sajilo_dokan/domain/response/cart_response.dart';
import 'package:sajilo_dokan/domain/response/category.dart';
import 'package:sajilo_dokan/domain/response/comment_response.dart';
import 'package:sajilo_dokan/domain/response/login_response.dart';
import 'package:sajilo_dokan/domain/response/order_response.dart';
import 'package:sajilo_dokan/domain/response/post_comment_response.dart';
import 'package:sajilo_dokan/domain/response/product.dart';
import 'package:sajilo_dokan/domain/response/update_cart_response.dart';
import 'package:sajilo_dokan/domain/response/user_response.dart';
import 'package:sajilo_dokan/domain/response/viet_nam.dart';

abstract class ApiRepositoryInterface {
  Future<List<Category>?> getCategories();

  Future<Product?> getCategoryProduct(int? idCategory, int? page, String? sort,
      String? productName, int? categoryId);

  Future<Product?> getRecommendProduct(
      int? limit, int? page, String? sort, int? id);

  Future<Content?> getProductDetail(int id);

  Future<CommentResponse?> getCommentProduct(
      int? idCategory, int? page, String? sort, int? productId);

  Future<CartResponse?> getCartList(
      int? limit, int? page, String? sort, int? customerId);

  Future<AddCartResponse?> payment(AddOrderRequest addOrderRequest);

  Future<String?> paymentByPaypal(AddOrderRequest addOrderRequest);

  Future<OrderResponse?> getOrderHistory(
    int? limit,
    int? page,
    String? sort,
    int? customerId,
  );

  Future<PostCommentResponse?> createComment(CommentRequest commentRequest);

  Future<UpdateCartResponse?> updateCart(AddCartRequest addCartRequest, int id);

  Future<UpdateCartResponse?> feedback(FeedbackRequest feedbackRequest);

  Future<UpdateCartResponse?> cancelOrder(
      CancelOrderRequest cancelOrderRequest, int id);

  Future<AddCartResponse?> addToCart(AddCartRequest addCartRequest);

  Future<CommentResponse?> deleteCart(int? id);

  Future<bool> makeFavorite(String token, int? id);

  Future<List<ProductComment>?> getComments(String? token, int? id);

  Future<bool> likeComment(String token, int? id);

  Future<bool> dislikeComment(String token, int? id);

  Future<bool> addQuantity(String? token, int? id, int quantity);

  Future<LoginResponse?> refreshToken(String refreshToken);

  Future<List<VietNam>> getProvinces();

  Future<UserResponse?> getCustomer(int id);
}
