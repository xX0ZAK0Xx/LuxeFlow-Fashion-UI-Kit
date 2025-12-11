import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/category_entity.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProducts implements UseCase<List<ProductEntity>, GetProductsParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetProductsParams params) async => repository.getProducts(categoryId: params.categoryId, searchQuery: params.searchQuery);
}

class GetProductsParams extends Equatable {
  final String? categoryId;
  final String? searchQuery;

  const GetProductsParams({this.categoryId, this.searchQuery});

  @override
  List<Object?> get props => [categoryId, searchQuery];
}

class GetCategories implements UseCase<List<CategoryEntity>, NoParams> {
  final ProductRepository repository;

  GetCategories(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async => repository.getCategories();
}
