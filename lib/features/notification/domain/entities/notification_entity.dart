import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final String time;
  final bool isRead;
  final String type; // 'shipping', 'offer', 'payment', 'general'

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, body, time, isRead, type];

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? body,
    String? time,
    bool? isRead,
    String? type,
  }) => NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
}
