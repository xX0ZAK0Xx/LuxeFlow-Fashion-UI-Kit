import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/shipping_address_entity.dart';
import '../../domain/repositories/shipping_repository.dart';
import '../datasources/shipping_local_data_source.dart';

class ShippingRepositoryImpl implements ShippingRepository {
  final ShippingLocalDataSource localDataSource;

  ShippingRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ShippingAddressEntity>>> getAddresses() async {
    try {
      final result = await localDataSource.getAddresses();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addAddress(ShippingAddressEntity address) async {
    try {
      await localDataSource.addAddress(address);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddress(String id) async {
    try {
      await localDataSource.deleteAddress(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setDefaultAddress(String id) async {
    try {
      await localDataSource.setDefaultAddress(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
