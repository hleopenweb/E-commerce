// To parse this JSON data, do
//
//     final cartRequest = cartRequestFromJson(jsonString);

class Cart {
  Cart({
    this.createdBy,
    this.customerId,
    this.note,
    this.totalCost,
    this.address,
    this.status,
    this.paymentMethod,
    this.cartItems,
  });

  String? createdBy;
  int? customerId;
  String? note;
  int? totalCost;
  String? address;
  String? status;
  String? paymentMethod;
  List<CartItem>? cartItems;
}

class CartItem {
  CartItem({
    this.createdBy,
    this.productId,
    this.quantity,
    this.salePrice,
  });

  String? createdBy;
  int? productId;
  int? quantity;
  int? salePrice;
}
