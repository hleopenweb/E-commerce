
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/model/user_model.dart';
import 'package:sajilo_dokan/domain/repository/product_repository/api_repository.dart';
import 'package:sajilo_dokan/domain/request/add_order_request.dart';
import 'package:sajilo_dokan/domain/response/viet_nam.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class PaymentCashController extends GetxController {
  PaymentCashController({required this.apiRepositoryInterface});

  final ApiRepositoryInterface apiRepositoryInterface;
  final formKey = GlobalKey<FormState>();

  final listVietNam = RxList<VietNam>();
  final listProvinces = RxList<String>();
  final listDistricts = RxList<String>();
  final listWards = RxList<String>();
  final initialTinh = 'Tất cả'.obs;
  final initialHuyen = 'Tất cả'.obs;
  final initialXa = 'Tất cả'.obs;
  RxBool isLoadingPayment = false.obs;
  late int totalAmount;
  late String paymentMethod;

  final province = ''.obs;
  final district = ''.obs;
  final ward = ''.obs;
  final stNo = ''.obs;
  final note = ''.obs;

  Future<void> getProvinces() async {
    final data = await apiRepositoryInterface.getProvinces();
    listVietNam.value = data;
    listProvinces.add('Tất cả');
    for (final element in listVietNam) {
      listProvinces.add(element.name!);
    }
  }

  @override
  Future<void> onInit() async {
    await getProvinces();
    totalAmount = Get.arguments[0]['totalAmount'] as int;
    paymentMethod = Get.arguments[1]['paymentMethod'] as String;
    super.onInit();
  }

  void findListDistricts(String data) {
    initialTinh.value = data;
    listDistricts.clear();
    listWards.clear();
    initialHuyen.value = 'Tất cả';
    if (initialTinh.value != 'Tất cả') {
      listDistricts.add('Tất cả');
      listDistricts.addAll(listVietNam
          .firstWhere((element) => element.name == data)
          .districts!
          .map((e) => e.name!)
          .toList());
      initialHuyen.value = listDistricts.first;
    }
  }

  void findListWards(String data) {
    initialHuyen.value = data;
    listWards.clear();
    initialXa.value = 'Tất cả';
    if (initialHuyen.value != 'Tất cả') {
      listWards.add('Tất cả');
      listWards.addAll(
        listVietNam
            .firstWhere((province) => province.name == initialTinh.value)
            .districts!
            .firstWhere((district) => district.name == data)
            .wards!
            .map((e) => e.name!)
            .toList(),
      );
      initialXa.value = listWards.first;
    }
  }

  Future<void> payment(BuildContext context) async {
    FocusScope.of(context).unfocus();
    switch (paymentMethod) {
      case 'CASH':
        paymentByCash();
        break;
      default:
        paymentByPaypal();
    }
  }

  Future<void> paymentByCash() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoadingPayment(true);
        await apiRepositoryInterface.payment(
          AddOrderRequest(
            customerId: UserModel().id,
            totalCost: totalAmount,
            note: note.value,
            address:
                '${stNo.value}, ${ward.value}, ${district.value}, ${province.value}',
            status: 'PENDING',
            paymentMethod: 'CASH',
          ),
        );
        Get.toNamed(Routes.paymentSuccess);
      } catch (e) {
        isLoadingPayment(false);
        rethrow;
      } finally {
        isLoadingPayment(false);
      }
    } else {
      Get.snackbar('Lỗi thanh toán', 'Vui lòng kiểm tra lại thông tin!',
          snackStyle: SnackStyle.FLOATING);
    }
  }

  Future<void> paymentByPaypal() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoadingPayment(true);
        final html = await apiRepositoryInterface.paymentByPaypal(
          AddOrderRequest(
            customerId: UserModel().id,
            totalCost: totalAmount,
            note: note.value,
            address:
                '${stNo.value}, ${ward.value}, ${district.value}, ${province.value}',
            status: 'PAID',
            paymentMethod: 'PAYPAL',
          ),
        );
         Get.toNamed(Routes.paymentPaypal, arguments: html);
      } catch (e) {
        isLoadingPayment(false);
        rethrow;
      } finally {
        isLoadingPayment(false);
      }
    } else {
      Get.snackbar('Lỗi thanh toán', 'Vui lòng kiểm tra lại thông tin!',
          snackStyle: SnackStyle.FLOATING);
    }
  }
}

