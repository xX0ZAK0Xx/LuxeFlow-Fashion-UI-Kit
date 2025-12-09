import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/shipping_address_entity.dart';

abstract class ShippingRepository {
  Future<Either<Failure, List<ShippingAddressEntity>>> getAddresses();
  Future<Either<Failure, void>> addAddress(ShippingAddressEntity address);
  Future<Either<Failure, void>> deleteAddress(String id);
  Future<Either<Failure, void>> setDefaultAddress(String id);
}
