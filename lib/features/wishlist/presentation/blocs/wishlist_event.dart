part of 'wishlist_bloc.dart';

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
