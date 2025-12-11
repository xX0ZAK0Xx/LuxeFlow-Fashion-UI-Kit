part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddProductToCart extends CartEvent {
  final ProductEntity product;
  final String? color;
  final String? size;

  const AddProductToCart(this.product, {this.color, this.size});

  @override
  List<Object?> get props => [product, color, size];
}

class RemoveProductFromCart extends CartEvent {
  final ProductEntity product;
  const RemoveProductFromCart(this.product);
  @override
  List<Object> get props => [product];
}

class UpdateCartItemQuantity extends CartEvent {
  final ProductEntity product;
  final int quantity;
  const UpdateCartItemQuantity(this.product, this.quantity);
  @override
  List<Object> get props => [product, quantity];
}

class ClearCartEvent extends CartEvent {}
