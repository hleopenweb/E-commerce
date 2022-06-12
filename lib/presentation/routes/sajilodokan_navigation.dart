import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sajilo_dokan/bindings/main_binding.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category/bindings/categories_binding.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category/views/category_screen.dart';
import 'package:sajilo_dokan/presentation/pages/Category/product/bindings/products_binding.dart';
import 'package:sajilo_dokan/presentation/pages/Category/product/views/category_products.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_binding.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_screen.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_binding.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_screen.dart';
import 'package:sajilo_dokan/presentation/pages/details/view/image_screen.dart';
import 'package:sajilo_dokan/presentation/pages/forgot-password/check_account_screen.dart';
import 'package:sajilo_dokan/presentation/pages/forgot-password/create_new_password_screen.dart';
import 'package:sajilo_dokan/presentation/pages/forgot-password/forgot_password_binding.dart';
import 'package:sajilo_dokan/presentation/pages/forgot-password/send_code_screen.dart';

import 'package:sajilo_dokan/presentation/pages/home/home_screen.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_binding.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/landing_home.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_binding.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_screen.dart';
import 'package:sajilo_dokan/presentation/pages/order_history/order_binding.dart';
import 'package:sajilo_dokan/presentation/pages/order_history/order_screen.dart';
import 'package:sajilo_dokan/presentation/pages/payment/payment_binding.dart';
import 'package:sajilo_dokan/presentation/pages/payment/payment_view.dart';
import 'package:sajilo_dokan/presentation/pages/payment_cash/payment_cash_binding.dart';
import 'package:sajilo_dokan/presentation/pages/payment_cash/payment_cash_view.dart';
import 'package:sajilo_dokan/presentation/pages/payment_success/payment_success_binding.dart';
import 'package:sajilo_dokan/presentation/pages/payment_success/payment_success_view.dart';
import 'package:sajilo_dokan/presentation/pages/profile_screen/profile_binding.dart';
import 'package:sajilo_dokan/presentation/pages/profile_screen/profile_view.dart';
import 'package:sajilo_dokan/presentation/pages/splash/splash_screen.dart';
import 'package:sajilo_dokan/presentation/pages/splash/splash_binding.dart';
import 'package:sajilo_dokan/presentation/payment_by_paypal/payment_paypal_binding.dart';
import 'package:sajilo_dokan/presentation/payment_by_paypal/payment_paypal_view.dart';

class Routes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String landingHome = '/landingHome';
  static const String productDetails = '/productDetails';
  static const String cart = '/cart';
  static const String categoryProduct = '/categoryProduct';
  static const String category = '/category';
  static const String imageScreen = '/imageScreen';
  static const String checkAccount = '/checkAccount';
  static const String sendCodeScreen = '/sendCodeScreen';
  static const String createNewPassword = '/createNewPassword';
  static const String payment = '/payment';
  static const String paymentByCash = '/paymentByCash';
  static const String paymentSuccess = '/paymentSuccess';
  static const String paymentPaypal = '/paymentPaypal';
  static const String profile = '/profile';
  static const String orderHistory = '/orderHistory';
}

class SajiloDokanPages {
  final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.home, page: () => Home()),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      bindings: [
        MainBinding(),
        LoginBinding(),
      ],
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.landingHome,
      page: () => LandingHome(),
      bindings: [
        MainBinding(),
        HomeBinding(),
        CategoriesBinding(),
        CartBinding()
      ],
    ),
    GetPage(
      name: Routes.productDetails,
      page: () => ProductDetailsScreen(),
      binding: ProductDetailsBinding(),
      bindings: [ProductDetailsBinding(), MainBinding()],
    ),
    GetPage(
        name: Routes.cart,
        page: () => CartScreen(),
        bindings: [MainBinding(), CartBinding()]),
    GetPage(
      name: Routes.category,
      page: () => CategoryScreen(),
      bindings: [MainBinding(), CategoriesBinding(), HomeBinding()],
    ),
    GetPage(
      name: Routes.categoryProduct,
      page: () => CategoryProducts(),
      binding: ProductBinding(),
    ),
    GetPage(name: Routes.imageScreen, page: () => ImageScreen(), bindings: [
      ProductDetailsBinding(),
    ]),
    GetPage(
      name: Routes.checkAccount,
      page: () => CheckAccountScreen(),
      bindings: [MainBinding(), ForgotPasswordBinding()],
    ),
    GetPage(
      name: Routes.sendCodeScreen,
      page: () => SendCodeScreen(),
    ),
    GetPage(
      name: Routes.createNewPassword,
      page: () => CreateNewPassword(),
    ),
    GetPage(
      name: Routes.payment,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: Routes.paymentByCash,
      page: () => PaymentCashView(),
      binding: PaymentCashBinding(),
    ),
    GetPage(
      name: Routes.paymentSuccess,
      page: () => PaymentSuccessView(),
      binding: PaymentSuccessBinding(),
    ),
    GetPage(
      name: Routes.paymentPaypal,
      page: () => PaymentPaypalView(),
      binding: PaymentPaypalBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.orderHistory,
      page: () => OrderScreen(),
      binding: OrderBinding(),
    )
  ];
}
