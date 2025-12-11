import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product/domain/entities/product_entity.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

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
