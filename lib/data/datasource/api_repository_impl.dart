import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sajilo_dokan/data/datasource/base_url.dart';
import 'package:sajilo_dokan/domain/model/product_comment.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/request/add_cart_request.dart';
import 'package:sajilo_dokan/domain/request/add_order_request.dart';
import 'package:sajilo_dokan/domain/request/cancel_order_request.dart';
import 'package:sajilo_dokan/domain/request/cart_request.dart';
import 'package:sajilo_dokan/domain/request/comment_request.dart';
import 'package:sajilo_dokan/domain/request/feedback_request.dart';
import 'package:sajilo_dokan/domain/request/new_password_request.dart';
import 'package:sajilo_dokan/domain/response/add_cart_response.dart';
import 'package:sajilo_dokan/domain/response/cart_response.dart';
import 'package:sajilo_dokan/domain/response/category.dart';
import 'package:sajilo_dokan/domain/response/comment_response.dart';
import 'package:sajilo_dokan/domain/response/order_response.dart';
import 'package:sajilo_dokan/domain/response/post_comment_response.dart';
import 'package:sajilo_dokan/domain/response/product.dart';
import 'package:sajilo_dokan/domain/response/update_cart_response.dart';
import 'package:sajilo_dokan/domain/response/user_response.dart';
import 'package:sajilo_dokan/domain/response/viet_nam.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface with BaseData {
  @override
  Future<List<Category>?> getCategories() async {
    final result = await client
        .get(getMainTestUrl(endpoint: '/api/categories', isQuery: false));
    final jsonData = result.bodyBytes;
    print('Get Category List called');
    if (result.statusCode == 200) {
      return categoryFromJson(utf8.decode(jsonData));
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await getCategories();
      } else {
        logOut();
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserResponse?> getCustomer(int id) async {
    final result = await client
        .get(getMainTestUrl(endpoint: '/api/customers/$id', isQuery: false));
    final jsonData = result.bodyBytes;
    print('Get user profile called');
    if (result.statusCode == 200) {
      return UserResponse.fromRawJson(utf8.decode(jsonData));
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await getCustomer(id);
      } else {
        logOut();
      }
    } else {
      return null;
    }
  }

  @override
  Future<PostCommentResponse?> createComment(
      CommentRequest commentRequest) async {
    final result = await client.post(
      getMainTestUrl(endpoint: '/api/comments', isQuery: false),
      headers: headerWithoutAuth,
      body: jsonEncode({
        'comment': commentRequest.comment,
        'productId': commentRequest.productId,
        'customerId': commentRequest.customerId,
      }),
    );
    if (result.statusCode == 201) {
      final jsonData = result.body;
      print('comment success');
      return PostCommentResponse.fromRawJson(jsonData);
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await createComment(commentRequest);
      } else {
        logOut();
      }
    }
    return null;
  }

  @override
  Future<UpdateCartResponse?> addCart(CartRequest cartRequest) async {
    final result = await client.put(
      getMainTestUrl(endpoint: '/api/carts', isQuery: false),
      headers: headerWithoutAuth,
      body: jsonEncode(cartRequest.toJson()),
    );
    if (result.statusCode == 200) {
      final jsonData = result.body;
      print('create cart success');
      return UpdateCartResponse.fromRawJson(jsonData);
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        addCart(cartRequest);
      } else {
        logOut();
      }
    }
    return null;
  }

  @override
  Future<CommentResponse?> getCommentProduct(
      int? limit, int? page, String? sort, int? productId) async {
    setValueOfQuery(limit: limit, page: page, sort: sort, productId: productId);
    final result = await client.get(getMainTestUrl(endpoint: '/api/comments'),
        headers: headerWithoutAuth);
    final jsonData = result.bodyBytes;
    print('Comments call');
    if (result.statusCode == 200) {
      return CommentResponse.fromRawJson(utf8.decode(jsonData));
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        getCommentProduct(limit, page, sort, productId);
      } else {
        logOut();
      }
    } else {
      return null;
    }
  }

  @override
  Future<Product?> getCategoryProduct(int? limit, int? page, String? sort,
      String? productName, int? categoryId) async {
    setValueOfQuery(
        limit: limit,
        page: page,
        sort: sort,
        productName: productName,
        categoryId: categoryId);
    final result = await client.get(getMainTestUrl(endpoint: '/api/products'),
        headers: headerWithoutAuth);
    final jsonData = result.bodyBytes;
    print('CategoryProducts call');
    if (result.statusCode == 200) {
      return Product.fromRawJson(utf8.decode(jsonData));
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        getCategoryProduct(limit, page, sort, productName, categoryId);
      } else {
        logOut();
      }
    } else {
      return null;
    }
  }

  @override
  Future<Product?> getRecommendProduct(
      int? limit, int? page, String? sort, int? id) async {
    setValueOfQuery(
      limit: limit,
      page: page,
      sort: sort,
    );
    final result = await client.get(
      getMainTestUrl(endpoint: '/api/products/recommendSystem/$id'),
      headers: headerWithoutAuth,
    );
    final jsonData = result.bodyBytes;
    print('Recommend system product call');
    if (result.statusCode == 200) {
      return Product.fromRawJson(utf8.decode(jsonData));
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        getRecommendProduct(limit, page, sort, id);
      } else {
        logOut();
      }
    } else {
      return null;
    }
  }

  @override
  Future<Content?> getProductDetail(int id) async {
    final result = await client.get(
        getMainTestUrl(endpoint: '/api/products/$id'),
        headers: headerWithoutAuth);
    final jsonData = result.bodyBytes;
    print('Product detail call');
    if (result.statusCode == 200) {
      return Content.fromRawJson(utf8.decode(jsonData));
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        getProductDetail(id);
      } else {
        logOut();
      }
    } else {
      return null;
    }
  }

  @override
  Future<CartResponse?> getCartList(
      int? limit, int? page, String? sort, int? customerId) async {
    setValueOfQuery(
      limit: limit,
      page: page,
      sort: sort,
      customerId: customerId,
    );
    final result = await client.get(
        getMainTestUrl(endpoint: '/api/cartTemps/customers/$customerId'),
        headers: headerWithoutAuth);
    final jsonData = result.bodyBytes;
    print('CartResponse call');
    if (result.statusCode == 200) {
      return CartResponse.fromRawJson(utf8.decode(jsonData));
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await getCartList(limit, page, sort, customerId);
      } else {
        logOut();
      }
    } else {
      return null;
    }
  }

  @override
  Future<AddCartResponse?> addToCart(AddCartRequest addCartRequest) async {
    final result = await client.post(
      getMainTestUrl(endpoint: '/api/cartTemps', isQuery: false),
      headers: headerWithoutAuth,
      body: jsonEncode({
        'customerId': addCartRequest.customerId,
        'productId': addCartRequest.productId,
        'quantity': addCartRequest.quantity,
        'salePrice': addCartRequest.salePrice
      }),
    );
    if (result.statusCode == 201) {
      final jsonData = result.body;
      print('add cart success');
      return AddCartResponse.fromRawJson(jsonData);
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await addToCart(addCartRequest);
      } else {
        logOut();
      }
    }
    return null;
  }

  @override
  Future<CommentResponse?> deleteCart(int? id) async {
    final result = await client.delete(
      getMainTestUrl(endpoint: '/api/cartTemps/$id', isQuery: false),
    );
    if (result.statusCode == 200) {
      final jsonData = result.bodyBytes;
      return CommentResponse.fromRawJson(utf8.decode(jsonData));
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        deleteCart(id);
      } else {
        logOut();
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> makeFavorite(String token, int? id) async {
    var result = await client.post(getMainUrl('/api/makefavorite/'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'id': '$id'
    });
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<List<ProductComment>?> getComments(String? token, int? id) async {
    var result = await client.get(getMainUrl('/api/comments/$id'),
        headers: token != null ? header(token) : null);
    var jsonData = result.body;
    // print(jsonData);
    if (result.statusCode == 200) {
      return productCommentFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<bool> dislikeComment(String token, int? id) async {
    var result = await client.post(getMainUrl('/api/dislike/'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'id': '$id'
    });
    print(result);
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> likeComment(String token, int? id) async {
    var result = await client.post(getMainUrl('/api/like/'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'id': '$id'
    });
    print(result.body);

    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> addQuantity(String? token, int? id, int quantity) async {
    print('Add Quantity');
    print('$token, $id, $quantity');
    var result = await client.post(getMainUrl('/api/add-quantity/'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'id': '$id',
      'quantity': '$quantity'
    });
    print('Add Quantity');

    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<UpdateCartResponse?> updateCart(
      AddCartRequest addCartRequest, int id) async {
    final result = await client.put(
      getMainTestUrl(endpoint: '/api/cartTemps/$id', isQuery: false),
      headers: headerWithoutAuth,
      body: jsonEncode({
        'customerId': addCartRequest.customerId,
        'productId': addCartRequest.productId,
        'quantity': addCartRequest.quantity,
        'salePrice': addCartRequest.salePrice
      }),
    );
    if (result.statusCode == 200) {
      final jsonData = result.body;
      print('update cart success');
      return UpdateCartResponse.fromRawJson(jsonData);
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await updateCart(addCartRequest, id);
      } else {
        logOut();
      }
    }
    return null;
  }

  @override
  Future<UpdateCartResponse?> feedback(FeedbackRequest feedbackRequest) async {
    final result = await client.post(
      getMainTestUrl(endpoint: '/api/feedbacks', isQuery: false),
      headers: headerWithoutAuth,
      body: jsonEncode({
        'customerId': feedbackRequest.customerId,
        'rating': feedbackRequest.rating,
        'productId': feedbackRequest.productId,
      }),
    );
    if (result.statusCode == 200) {
      final jsonData = result.body;
      print('feedback success');
      return UpdateCartResponse.fromRawJson(jsonData);
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await feedback(feedbackRequest);
      } else {
        logOut();
      }
    }
    return null;
  }

  @override
  Future<UpdateCartResponse?> cancelOrder(
      CancelOrderRequest cancelOrderRequest, int id) async {
    final result = await client.put(
      getMainTestUrl(endpoint: '/api/carts/status/$id', isQuery: false),
      headers: headerWithoutAuth,
      body: jsonEncode({
        'userId': cancelOrderRequest.userId,
        'status': cancelOrderRequest.status,
      }),
    );
    if (result.statusCode == 200) {
      final jsonData = result.body;
      print('cancel order success');
      return UpdateCartResponse.fromRawJson(jsonData);
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await cancelOrder(cancelOrderRequest, id);
      } else {
        logOut();
      }
    }
    return null;
  }

  @override
  Future<AddCartResponse?> payment(AddOrderRequest addOrderRequest) async {
    final result = await client.post(
      getMainTestUrl(endpoint: '/api/carts', isQuery: false),
      headers: headerWithoutAuth,
      body: jsonEncode(addOrderRequest.toJson()),
    );
    if (result.statusCode == 201) {
      final jsonData = result.body;
      print('add cart success');
      return AddCartResponse.fromRawJson(jsonData);
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await payment(addOrderRequest);
      } else {
        logOut();
      }
    }
    return null;
  }

  @override
  Future<OrderResponse?> getOrderHistory(
      int? limit, int? page, String? sort, int? customerId) async {
    setValueOfQuery(
      limit: limit,
      page: page,
      sort: sort,
      customerId: customerId,
    );
    final result = await client.get(
        getMainTestUrl(endpoint: '/api/carts/customers/$customerId'),
        headers: headerWithoutAuth);
    final jsonData = result.bodyBytes;
    print('OrderResponse call');
    if (result.statusCode == 200) {
      return OrderResponse.fromRawJson(utf8.decode(jsonData));
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await getOrderHistory(limit, page, sort, customerId);
      } else {
        logOut();
      }
    } else {
      return null;
    }
  }

  @override
  Future<List<VietNam>> getProvinces() async {
    final data = await rootBundle.loadString(
      'assets/province.json',
    );
    Iterable l = jsonDecode(data);
    List<VietNam> posts =
        List<VietNam>.from(l.map((model) => VietNam.fromJson(model)));
    return posts;
  }

  @override
  Future<String?> paymentByPaypal(AddOrderRequest addOrderRequest) async {
    final result = await http.post(
      Uri.parse('https://cnpm-ecommerce.herokuapp.com/api/carts'),
      headers: headerWithoutAuth,
      body: jsonEncode(addOrderRequest.toJson()),
    );
    if (result.statusCode == 200) {
      final jsonData = result.body;
      print('payment cart success');
      return jsonData;
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await paymentByPaypal(addOrderRequest);
      } else {
        logOut();
      }
    }
    return null;
  }
}
