import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetNotifications implements UseCase<List<NotificationEntity>, NoParams> {
  final NotificationRepository repository;

  GetNotifications(this.repository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(NoParams params) async => repository.getNotifications();
}

class MarkAllNotificationsAsRead implements UseCase<void, NoParams> {
  final NotificationRepository repository;

  MarkAllNotificationsAsRead(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async => repository.markAllAsRead();
}

class MarkNotificationAsRead implements UseCase<void, String> {
  final NotificationRepository repository;

  MarkNotificationAsRead(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async => repository.markAsRead(params);
}
