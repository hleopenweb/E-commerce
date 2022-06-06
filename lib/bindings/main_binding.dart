import 'package:get/get.dart';
import 'package:sajilo_dokan/data/datasource/api_repository_impl.dart';
import 'package:sajilo_dokan/data/datasource/local_repository_impl.dart';
import 'package:sajilo_dokan/data/datasource/user_repository_impl.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalRepositoryInterface>(() => LocalRepositoryImpl());
    Get.lazyPut<UserRepositoryInterface>(() => UserRepositoryImpl());
    Get.lazyPut<ApiRepositoryInterface>(() => ApiRepositoryImpl());
  }
}
