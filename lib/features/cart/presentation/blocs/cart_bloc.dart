import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/usecases/cart_usecases.dart';

part 'cart_event.dart';
part 'cart_state.dart';

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

  double _calculateTotal(List<CartItemEntity> items) => items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
}
