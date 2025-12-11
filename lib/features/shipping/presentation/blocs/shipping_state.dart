part of 'shipping_bloc.dart';

abstract class ShippingState extends Equatable {
  const ShippingState();
  @override
  List<Object> get props => [];
}

class ShippingInitial extends ShippingState {}
class ShippingLoading extends ShippingState {}
class ShippingLoaded extends ShippingState {
  final List<ShippingAddressEntity> addresses;
  const ShippingLoaded(this.addresses);
  @override
  List<Object> get props => [addresses];
}
class ShippingError extends ShippingState {
  final String message;
  const ShippingError(this.message);
  @override
  List<Object> get props => [message];
}
