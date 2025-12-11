import '../../domain/entities/cart_item_entity.dart';

import '../../../product/domain/entities/product_entity.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemEntity>> getCart();
  Future<void> addToCart(ProductEntity product, {String? color, String? size});
  Future<void> removeFromCart(ProductEntity product);
  Future<void> updateCartItemQuantity(ProductEntity product, int quantity);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  // In-memory storage
  final List<CartItemEntity> _cart = [];

  @override
  Future<void> addToCart(ProductEntity product, {String? color, String? size}) async {
    // Check if item exists with same ID and variants
    final index = _cart.indexWhere((item) => 
      item.product.id == product.id && 
      item.selectedColor == color && 
      item.selectedSize == size
    );

    if (index >= 0) {
      final existingItem = _cart[index];
      _cart[index] = existingItem.copyWith(quantity: existingItem.quantity + 1);
    } else {
      _cart.add(CartItemEntity(
        product: product, 
        quantity: 1,
        selectedColor: color,
        selectedSize: size,
      ));
    }
  }

  @override
  Future<void> clearCart() async {
    _cart.clear();
  }

  @override
  Future<List<CartItemEntity>> getCart() async => List.from(_cart);

  @override
  Future<void> removeFromCart(ProductEntity product) async {
    final index = _cart.indexWhere((item) => item.product.id == product.id);
    _cart.removeAt(index);
  }

  @override
  Future<void> updateCartItemQuantity(ProductEntity product, int quantity) async {
    final index = _cart.indexWhere((item) => item.product.id == product.id);
    if (quantity <= 0) {
      if (index >= 0) {
        _cart.removeAt(index);
      }
    } else {
      if (index >= 0) {
        _cart[index] = _cart[index].copyWith(quantity: quantity);
      } else {
        _cart.add(CartItemEntity(product: product, quantity: quantity));
      }
    }
  }
}
