// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:market/models/home_model.dart';

import 'favorite_model.dart';

class CartModel {
  final bool status;
  final String? message;
  final dynamic subTotal;
  final dynamic total;
  final CartData? data;
  CartModel({
    required this.status,
    required this.message,
    required this.subTotal,
    required this.total,
    required this.data,
  });
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        status: json['status'],
        message: json['message'],
        subTotal: json['sub_total'],
        total: json['total'],
        data: json['data'] != null ? CartData.fromJson(json['data']) : null);
  }
}

class CartData {
  List<CartItem> cartItem = [];
  CartData({
    required this.cartItem,
  });
  CartData.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((element) {
      cartItem.add(CartItem.fromJson(element));
    });
  }
}

class CartItem {
  final int id;
  final dynamic quantity;
  final Product product;
  CartItem({
    required this.id,
    required this.quantity,
    required this.product,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        quantity: json['quantity'],
        product: ProductModel.fromJson(json['product']));
  }
}
class CartItemDataModel {
  final int id;
 
  final ProductItem product;
  CartItemDataModel ({
    required this.id,
    
    required this.product,
  });
  factory CartItemDataModel .fromJson(Map<String, dynamic> json) {
    return CartItemDataModel (
        id: json['id'],
        
        product: ProductItem.fromJson(json['product']));
  }
}

