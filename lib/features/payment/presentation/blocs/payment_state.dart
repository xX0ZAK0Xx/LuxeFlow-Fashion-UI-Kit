part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}
class PaymentLoading extends PaymentState {}
class PaymentLoaded extends PaymentState {
  final List<PaymentMethodEntity> methods;
  const PaymentLoaded(this.methods);
  @override
  List<Object> get props => [methods];
}
class PaymentError extends PaymentState {
  final String message;
  const PaymentError(this.message);
  @override
  List<Object> get props => [message];
}
