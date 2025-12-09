import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class GetCart implements UseCase<List<CartItemEntity>, NoParams> {
  final CartRepository repository;

  GetCart(this.repository);

  @override
  Future<Either<Failure, List<CartItemEntity>>> call(NoParams params) async {
    return await repository.getCart();
  }
}

class AddToCart implements UseCase<void, AddToCartParams> {
  final CartRepository repository;

  AddToCart(this.repository);

  @override
  Future<Either<Failure, void>> call(AddToCartParams params) async {
    return await repository.addToCart(
      params.product, 
      color: params.color, 
      size: params.size,
    );
  }
}

class RemoveFromCart implements UseCase<void, ProductEntity> {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  @override
  Future<Either<Failure, void>> call(ProductEntity params) async {
    return await repository.removeFromCart(params);
  }
}

class UpdateCartItem implements UseCase<void, UpdateCartItemParams> {
  final CartRepository repository;

  UpdateCartItem(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateCartItemParams params) async {
    return await repository.updateCartItem(params.product, params.quantity);
  }
}

class UpdateCartItemParams {
  final ProductEntity product;
  final int quantity;

  UpdateCartItemParams({required this.product, required this.quantity});
}

class AddToCartParams {
  final ProductEntity product;
  final String? color;
  final String? size;

  AddToCartParams({required this.product, this.color, this.size});
}
