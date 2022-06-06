import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/response/login_response.dart';
import 'package:sajilo_dokan/domain/response/logout_response.dart';

mixin BaseData {
  http.Client client = http.Client();

  Uri getUrl(String endpoind, {String baseUrl = 'fakestoreapi.com'}) {
    var url = Uri.https('${(baseUrl)}', '${(endpoind)}', {'q': '{https}'});
    return url;
  }

  Uri getMainUrl(String endpoind,
      {String baseUrl = 'onlinehatiya.herokuapp.com'}) {
    var url = Uri.https('${(baseUrl)}', '${endpoind}', {'q': '{https}'});
    return url;
  }

  Map<String, String> header(String token) =>
      {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  Map<String, String> get headerWithoutAuth =>
      {
        'Content-type': 'application/json',
      };

  Map<String, String> get headerWebService=>
      {
        'Content-type': 'application/json',
        'Accept' : 'application/json'
      };

  Map<String, dynamic> queryProduct = {};

  void setValueOfQuery({int? limit,
    int? page,
    String? sort,
    String? productName,
    int? categoryId,
    int? productId,
    int? customerId,
  }) {
    queryProduct = {};
    if (limit != null) {
      queryProduct['limit'] = limit.toString();
    }
    if (page != null) {
      queryProduct['page'] = page.toString();
    }
    if (productName != null) {
      queryProduct['q'] = productName;
    }
    if (categoryId != null) {
      queryProduct['categoryId'] = categoryId.toString();
    }
    if (productId != null) {
      queryProduct['productId'] = productId.toString();
    }
    if (sort != null) {
      queryProduct['sort'] = sort;
    }
    if (customerId != null) {
      queryProduct['customerId'] = customerId.toString();
    }
  }

  Uri getMainTestUrl({required String endpoint,
    String baseUrl = 'cnpm-ecommerce.herokuapp.com',
    bool isQuery = true}) {
    final Uri uri;
    if (isQuery) {
      uri = Uri.https(baseUrl, endpoint, queryProduct);
    } else {
      uri = Uri.https(baseUrl, endpoint);
    }
    return uri;
  }

  Future<LoginResponse?> refreshToken(String refreshToken) async {
    print('refreshToken');
    final result = await client.post(
        getMainTestUrl(endpoint: '/api/auth/refreshtoken', isQuery: false),
        headers: headerWithoutAuth,
        body: jsonEncode({
          'refreshToken': refreshToken
        }));
    if (result.statusCode == 200) {
      final jsonData = result.body;
      return LoginResponse.fromRawJson(jsonData);
    } else {
      return null;
    }
  }

  Future<bool> getNewAccessToken() async {
    final loginResponse = await refreshToken(UserModel().refreshToken!);
    if (loginResponse != null) {
      UserModel().accessToken = loginResponse.token;
      return true;
    }
    return false;
  }

  Future<LogoutResponse?> logOut() async {
    print('logout');
    final result = await client.post(
        getMainTestUrl(endpoint: '/api/auth/logout', isQuery: false),
        headers: headerWithoutAuth,
        body: jsonEncode({
          'token': UserModel().accessToken,
          'userId': UserModel().id,
          'refreshToken': UserModel().refreshToken
        }));
    if (result.statusCode == 200) {
      final jsonData = result.body;
      return LogoutResponse.fromRawJson(jsonData);
    } else {
      return null;
    }
  }
}
