import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/usecases/payment_usecases.dart';

// Events
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

// States
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

// Bloc
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentMethods getMethods;
  final AddPaymentMethod addMethod;
  final DeletePaymentMethod deleteMethod;
  bool loaded = false;

  PaymentBloc({
    required this.getMethods,
    required this.addMethod,
    required this.deleteMethod,
  }) : super(PaymentInitial()) {
    on<LoadPaymentMethods>(_onLoadMethods);
    on<AddPaymentMethodEvent>(_onAddMethod);
    on<DeletePaymentMethodEvent>(_onDeleteMethod);
  }

  Future<void> _onLoadMethods(LoadPaymentMethods event, Emitter<PaymentState> emit) async {
    if(!loaded){
      emit(PaymentLoading());
      loaded = true;
    }
    final result = await getMethods(NoParams());
    result.fold(
      (failure) => emit(PaymentError(failure.message)),
      (methods) => emit(PaymentLoaded(methods)),
    );
  }

  Future<void> _onAddMethod(AddPaymentMethodEvent event, Emitter<PaymentState> emit) async {
    await addMethod(event.method);
    add(LoadPaymentMethods());
  }

  Future<void> _onDeleteMethod(DeletePaymentMethodEvent event, Emitter<PaymentState> emit) async {
    await deleteMethod(event.id);
    add(LoadPaymentMethods());
  }
}
