import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItemEntity>>> getCart();
  Future<Either<Failure, void>> addToCart(ProductEntity product);
  Future<Either<Failure, void>> removeFromCart(ProductEntity product); // Decrement or remove
  Future<Either<Failure, void>> updateCartItem(ProductEntity product, int quantity);
  Future<Either<Failure, void>> clearCart();
}
