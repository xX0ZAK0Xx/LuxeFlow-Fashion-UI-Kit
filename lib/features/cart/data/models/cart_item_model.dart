import 'package:luxeflow_fashion_ui_kit/features/product/data/product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });
}