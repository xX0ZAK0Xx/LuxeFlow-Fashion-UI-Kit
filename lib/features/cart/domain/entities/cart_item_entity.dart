import 'package:equatable/equatable.dart';
import '../../../product/domain/entities/product_entity.dart';

class CartItemEntity extends Equatable {
  final ProductEntity product;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;

  const CartItemEntity({
    required this.product,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
  });

  @override
  List<Object?> get props => [product, quantity, selectedColor, selectedSize];
  
  CartItemEntity copyWith({
    ProductEntity? product,
    int? quantity,
    String? selectedColor,
    String? selectedSize,
  }) {
    return CartItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }
}
