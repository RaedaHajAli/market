// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'cart_model.dart';

class ChangeCartItemModel {
  final bool status;
  final String? message;
  final CartItemDataModel? data;
  ChangeCartItemModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ChangeCartItemModel.fromJson(Map<String, dynamic> json) {
    return ChangeCartItemModel(
        status: json['status'],
        message: json['message'],
        data: json['data'] != null ? CartItemDataModel.fromJson(json['data']) : null);
  }
}
