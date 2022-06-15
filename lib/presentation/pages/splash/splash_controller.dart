import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/domain/repository/user/user_repository.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class SplashController extends GetxController {
  SplashController(
      {required this.localRepositoryInterface,
      required this.userRepositoryInterface});

  final LocalRepositoryInterface localRepositoryInterface;
  final UserRepositoryInterface userRepositoryInterface;

  @override
  Future<void> onReady() async {
    await validateSession();
    super.onReady();
  }

  Future<void> validateSession() async {
    final user = await localRepositoryInterface.getUser();
    if (user != null) {
      if (user.refreshToken != null) {
        final loginResponse =
            await userRepositoryInterface.refreshToken(user.refreshToken!);
        if (loginResponse != null) {
          UserModel().accessToken = loginResponse.token;
          localRepositoryInterface.saveToken(loginResponse.token);
          Get.offNamed(Routes.landingHome);
        } else {
          Future.delayed(Duration(seconds: 3)).then((value) {
            localRepositoryInterface.clearAllData();
            Get.offNamed(Routes.login);
          });
        }
      }
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) {
        Get.offNamed(Routes.login);
      });
    }
  }
}
