import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payment_method_entity.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentMethodEntity>>> getMethods();
  Future<Either<Failure, void>> addMethod(PaymentMethodEntity method);
  Future<Either<Failure, void>> deleteMethod(String id);
  Future<Either<Failure, void>> setDefaultMethod(String id);
}
