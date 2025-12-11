part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object> get props => [];
}

class LoadNotifications extends NotificationEvent {}

class MarkAllAsReadEvent extends NotificationEvent {}

class MarkAsReadEvent extends NotificationEvent {
  final String id;
  const MarkAsReadEvent(this.id);
  @override
  List<Object> get props => [id];
}
