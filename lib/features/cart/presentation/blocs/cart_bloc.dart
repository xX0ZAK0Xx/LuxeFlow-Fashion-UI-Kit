import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/usecases/cart_usecases.dart';

// Events
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

// States
abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;
  final double totalAmount;

  const CartLoaded({required this.items, required this.totalAmount});

  @override
  List<Object> get props => [items, totalAmount];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);
  @override
  List<Object> get props => [message];
}

// Bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCart getCart;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final UpdateCartItem updateCartItem;

  CartBloc({
    required this.getCart,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateCartItem,
  }) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddProductToCart>(_onAddProductToCart);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<ClearCartEvent>(_onClearCartEvent);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final result = await getCart(NoParams());
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (items) => emit(CartLoaded(
        items: items,
        totalAmount: _calculateTotal(items),
      )),
    );
  }

  Future<void> _onAddProductToCart(
    AddProductToCart event,
    Emitter<CartState> emit,
  ) async {
    await addToCart(AddToCartParams(
      product: event.product, 
      color: event.color, 
      size: event.size
    ));
    add(LoadCart());
  }

  Future<void> _onRemoveProductFromCart(
    RemoveProductFromCart event,
    Emitter<CartState> emit,
  ) async {
    await removeFromCart(event.product);
    add(LoadCart());
  }

  Future<void> _onUpdateCartItemQuantity(
    UpdateCartItemQuantity event,
    Emitter<CartState> emit,
  ) async {
    await updateCartItem(UpdateCartItemParams(
      product: event.product,
      quantity: event.quantity,
    ));
    add(LoadCart());
  }
  
  Future<void> _onClearCartEvent(
      ClearCartEvent event,
      Emitter<CartState> emit,
  ) async {
      add(LoadCart());
  }

  double _calculateTotal(List<CartItemEntity> items) {
    return items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}
