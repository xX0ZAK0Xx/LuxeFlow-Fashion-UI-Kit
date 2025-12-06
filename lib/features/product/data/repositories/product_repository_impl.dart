import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await localDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({String? categoryId, String? searchQuery}) async {
    try {
      final allProducts = await localDataSource.getProducts();
      var filtered = allProducts;
      
      if (categoryId != null) {
        filtered = filtered.where((p) => p.categoryId == categoryId).toList();
      }
      
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        filtered = filtered.where((p) => 
          p.name.toLowerCase().contains(query) || 
          p.description.toLowerCase().contains(query)
        ).toList();
      }

      return Right(filtered);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
