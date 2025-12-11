part of 'shipping_bloc.dart';

abstract class ShippingEvent extends Equatable {
  const ShippingEvent();
  @override
  List<Object> get props => [];
}

class LoadShippingAddresses extends ShippingEvent {}

class AddShippingAddressEvent extends ShippingEvent {
  final ShippingAddressEntity address;
  const AddShippingAddressEvent(this.address);
  @override
  List<Object> get props => [address];
}

class DeleteShippingAddressEvent extends ShippingEvent {
  final String id;
  const DeleteShippingAddressEvent(this.id);
  @override
  List<Object> get props => [id];
}
