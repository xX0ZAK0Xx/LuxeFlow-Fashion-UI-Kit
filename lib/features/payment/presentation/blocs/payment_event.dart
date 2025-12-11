part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
  @override
  List<Object> get props => [];
}

class LoadPaymentMethods extends PaymentEvent {}

class AddPaymentMethodEvent extends PaymentEvent {
  final PaymentMethodEntity method;
  const AddPaymentMethodEvent(this.method);
  @override
  List<Object> get props => [method];
}

class DeletePaymentMethodEvent extends PaymentEvent {
  final String id;
  const DeletePaymentMethodEvent(this.id);
  @override
  List<Object> get props => [id];
}
