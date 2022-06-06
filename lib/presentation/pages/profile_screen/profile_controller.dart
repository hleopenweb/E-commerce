import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/response/user_response.dart';

class ProfileController extends GetxController {
  ProfileController({required this.apiRepositoryInterface});

  final ApiRepositoryInterface apiRepositoryInterface;
  final TextEditingController name = TextEditingController();
  final Rx<UserResponse> user = UserResponse().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadUserProfile() ;
  }

  Future<void> loadUserProfile() async {
    try {
      user.value = await apiRepositoryInterface.getCustomer(UserModel().id ?? 0) ?? UserResponse();
    } catch (e) {
      rethrow;
    } finally {
    }
  }

  @override
  void onClose() {
    name.clear();
    super.onClose();
  }
}
