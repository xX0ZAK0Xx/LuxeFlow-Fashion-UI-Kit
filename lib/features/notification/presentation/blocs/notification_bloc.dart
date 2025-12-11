import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/notification_usecases.dart';

part 'notification_event.dart';
part 'notification_state.dart';

// Bloc
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotifications getNotifications;
  final MarkAllNotificationsAsRead markAllAsRead;
  final MarkNotificationAsRead markAsRead;

  NotificationBloc({
    required this.getNotifications,
    required this.markAllAsRead,
    required this.markAsRead,
  }) : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<MarkAllAsReadEvent>(_onMarkAllAsRead);
    on<MarkAsReadEvent>(_onMarkAsRead);
  }

  Future<void> _onLoadNotifications(LoadNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    final result = await getNotifications(NoParams());
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }

  Future<void> _onMarkAllAsRead(MarkAllAsReadEvent event, Emitter<NotificationState> emit) async {
    await markAllAsRead(NoParams());
    add(LoadNotifications());
  }

  Future<void> _onMarkAsRead(MarkAsReadEvent event, Emitter<NotificationState> emit) async {
    await markAsRead(event.id);
    add(LoadNotifications());
  }
}
