import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/shipping_address_entity.dart';
import '../repositories/shipping_repository.dart';

class GetShippingAddresses implements UseCase<List<ShippingAddressEntity>, NoParams> {
  final ShippingRepository repository;

  GetShippingAddresses(this.repository);

  @override
  Future<Either<Failure, List<ShippingAddressEntity>>> call(NoParams params) async => repository.getAddresses();
}

class AddShippingAddress implements UseCase<void, ShippingAddressEntity> {
  final ShippingRepository repository;

  AddShippingAddress(this.repository);

  @override
  Future<Either<Failure, void>> call(ShippingAddressEntity params) async => repository.addAddress(params);
}

class DeleteShippingAddress implements UseCase<void, String> {
  final ShippingRepository repository;

  DeleteShippingAddress(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async => repository.deleteAddress(params);
}
