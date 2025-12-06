import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product/domain/entities/product_entity.dart';

// Events
abstract class WishlistEvent extends Equatable {
  const WishlistEvent();
  @override
  List<Object> get props => [];
}

class LoadWishlist extends WishlistEvent {}

class ToggleWishlistItem extends WishlistEvent {
  final ProductEntity product;
  const ToggleWishlistItem(this.product);
  @override
  List<Object> get props => [product];
}

// States
abstract class WishlistState extends Equatable {
  const WishlistState();
  @override
  List<Object> get props => [];
}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductEntity> wishlist;
  const WishlistLoaded({this.wishlist = const []});
  @override
  List<Object> get props => [wishlist];
}

class WishlistError extends WishlistState {
  final String message;
  const WishlistError(this.message);
  @override
  List<Object> get props => [message];
}

// Bloc
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  // In-memory cache for simplicity in this phase
  final List<ProductEntity> _wishlist = [];

  WishlistBloc() : super(WishlistLoading()) {
    on<LoadWishlist>((event, emit) {
      emit(WishlistLoaded(wishlist: List.from(_wishlist)));
    });

    on<ToggleWishlistItem>((event, emit) {
      if (_wishlist.any((p) => p.id == event.product.id)) {
        _wishlist.removeWhere((p) => p.id == event.product.id);
      } else {
        _wishlist.add(event.product);
      }
      emit(WishlistLoaded(wishlist: List.from(_wishlist)));
    });
  }
}
