import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/shipping_address_entity.dart';
import '../../domain/usecases/shipping_usecases.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

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
