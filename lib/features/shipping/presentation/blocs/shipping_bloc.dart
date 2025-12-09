import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/shipping_address_entity.dart';
import '../../domain/usecases/shipping_usecases.dart';

// Events
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

// States
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

// Bloc
class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final GetShippingAddresses getAddresses;
  final AddShippingAddress addAddress;
  final DeleteShippingAddress deleteAddress;
  bool loaded = false;

  ShippingBloc({
    required this.getAddresses,
    required this.addAddress,
    required this.deleteAddress,
  }) : super(ShippingInitial()) {
    on<LoadShippingAddresses>(_onLoadAddresses);
    on<AddShippingAddressEvent>(_onAddAddress);
    on<DeleteShippingAddressEvent>(_onDeleteAddress);
  }

  Future<void> _onLoadAddresses(LoadShippingAddresses event, Emitter<ShippingState> emit) async {
    if(!loaded){
      emit(ShippingLoading());
      loaded = true;
    }
    final result = await getAddresses(NoParams());
    result.fold(
      (failure) => emit(ShippingError(failure.message)),
      (addresses) => emit(ShippingLoaded(addresses)),
    );
  }

  Future<void> _onAddAddress(AddShippingAddressEvent event, Emitter<ShippingState> emit) async {
    // Optimistic or waiting? Let's wait.
    await addAddress(event.address);
    add(LoadShippingAddresses());
  }

  Future<void> _onDeleteAddress(DeleteShippingAddressEvent event, Emitter<ShippingState> emit) async {
     await deleteAddress(event.id);
     add(LoadShippingAddresses());
  }
}
