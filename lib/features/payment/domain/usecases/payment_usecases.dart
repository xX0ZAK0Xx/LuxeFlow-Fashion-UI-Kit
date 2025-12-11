import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/payment_method_entity.dart';
import '../repositories/payment_repository.dart';

class GetPaymentMethods implements UseCase<List<PaymentMethodEntity>, NoParams> {
  final PaymentRepository repository;

  GetPaymentMethods(this.repository);

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> call(NoParams params) async => repository.getMethods();
}

class AddPaymentMethod implements UseCase<void, PaymentMethodEntity> {
  final PaymentRepository repository;

  AddPaymentMethod(this.repository);

  @override
  Future<Either<Failure, void>> call(PaymentMethodEntity params) async => repository.addMethod(params);
}

class DeletePaymentMethod implements UseCase<void, String> {
  final PaymentRepository repository;

  DeletePaymentMethod(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async => repository.deleteMethod(params);
}
