import 'dart:async';
import 'dart:convert';

import 'package:sajilo_dokan/data/datasource/base_url.dart';
import 'package:sajilo_dokan/domain/model/user_service.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';
import 'package:sajilo_dokan/domain/request/login_request.dart';
import 'package:sajilo_dokan/domain/request/new_password_request.dart';
import 'package:sajilo_dokan/domain/request/register_request.dart';
import 'package:sajilo_dokan/domain/response/login_response.dart';
import 'package:sajilo_dokan/domain/response/register_response.dart';
import 'package:sajilo_dokan/domain/response/update_cart_response.dart';

class UserRepositoryImpl extends UserRepositoryInterface with BaseData {
  @override
  Future<RegisterResponse?> register(RegisterRequest registerRequest) async {
    var result = await client.post(
        getMainTestUrl(endpoint: 'api/auth/signup', isQuery: false),headers: headerWithoutAuth,
        body: jsonEncode({
            'userName': registerRequest.userName,
            'password': registerRequest.password,
            'name': registerRequest.name,
            'phoneNumber': registerRequest.phone,
            'email': registerRequest.email,
            'gender': registerRequest.gender
        }));
    print('register');
    if (result.statusCode == 201) {
      var jsondata = result.body;
      print('Register');
      return RegisterResponse.fromRawJson(jsondata);
    } else {
      return null;
    }
  }

  @override
  Future<LoginResponse?> getUser() async {
    var result = await client.get(getMainUrl('/api/user/profile/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    if (result.statusCode == 200) {
      final jsonData = result.body;
      print('login');
      print(jsonData);
      return LoginResponse.fromRawJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<LoginResponse?> login(LoginRequest login) async {
    final result = await client.post(
      getMainTestUrl(endpoint: '/api/auth/signin', isQuery: false),
      headers: headerWithoutAuth,
      body:
          jsonEncode({'userName': login.userName, 'password': login.password}),
    );
    if (result.statusCode == 200) {
      final jsonData = result.body;
      print('login');
      return LoginResponse.fromRawJson(jsonData);
    }
    return null;
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
  Future<LoginResponse?> googleSignIn(String? idToken, String provider) async {
    var result =
        await client.post(getMainUrl('/social_auth/$provider/'), body: {
      'auth_token': idToken,
    });
    print('GoogleSignIn');
    if (result.statusCode == 200) {
      var jsondata = result.body;

      return LoginResponse.fromRawJson(jsondata);
    } else {
      return null;
    }
  }

  @override
  Future<bool> forgetPassword(String email) async {
    print(email);
    var result = await client
        .patch(getMainUrl('/api/forget-password'), body: {'email': '$email'});

    print(result.body);
    if (result.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String?> verifyForgetPasswordCode(String email, String otp) async {
    final result = await client.post(getMainUrl('/api/forget-password'),
        body: {'email': '$email', 'otp': '$otp'});
    var data = result.body;
    var dd = jsonDecode(data);

    if (result.statusCode == 200) {
      return dd['token'];
    }
    return null;
  }

  @override
  Future<LoginResponse?> createNewPassword(
      String token, String newPassword) async {
    final queryParameters = {
      'q': '{https}',
      'token': token,
    };
    var uri = Uri.https(
      'onlinehatiya.herokuapp.com',
      '/api/change-password',
      queryParameters,
    );
    var result = await client.post(uri, body: {'new_password': '$newPassword'});
    print(newPassword);
    print(result.body);
    if (result.statusCode == 200) {
      var jsondata = result.body;
      print(jsondata);
      return LoginResponse.fromRawJson(jsondata);
    }
    return null;
  }

  @override
  Future<UserService?> getUserFromId(int id) async {
    var result = await client
        .get(getMainTestUrl(endpoint: '/api/customers/$id'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    if (result.statusCode == 200) {
      final jsonData = result.body;
      print('getUserFromId');
      print(jsonData);
      return UserService.fromRawJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<UpdateCartResponse?> changePassword(NewPasswordRequest passwordRequest) async {
    final result = await client.post(
      getMainTestUrl(endpoint: '/api/password/edit', isQuery: false),
      headers: headerWithoutAuth,
      body: jsonEncode({
        'email': passwordRequest.email,
        'oldPassword': passwordRequest.oldPassword,
        'password': passwordRequest.password,
      }),
    );
    if (result.statusCode == 200) {
      final jsonData = result.body;
      print('change Password success');
      return UpdateCartResponse.fromRawJson(jsonData);
    } else if (result.statusCode == 401) {
      if (await getNewAccessToken()) {
        await changePassword(passwordRequest);
      } else {
        logOut();
      }
    }
    return null;

  }
}
