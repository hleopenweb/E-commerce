import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class Brand extends Equatable {
  Brand({
    this.brand,
    this.isChoose,
  });

  String? brand;
  RxBool? isChoose;

  @override
  List<Object?> get props => [brand];
}
