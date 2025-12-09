import '../../domain/entities/notification_entity.dart';

abstract class NotificationLocalDataSource {
  Future<List<NotificationEntity>> getNotifications();
  Future<void> markAllAsRead();
  Future<void> markAsRead(String id);
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  final List<NotificationEntity> _notifications = [
    const NotificationEntity(
      id: '1',
      title: 'Order Shipped!',
      body: 'Your order #12345 has been shipped and is on its way.',
      time: '2 hours ago',
      isRead: false,
      type: 'shipping',
    ),
    const NotificationEntity(
      id: '2',
      title: 'New Collection Alert',
      body: 'Check out our new Winter Collection. Limited stock!',
      time: '5 hours ago',
      isRead: false,
      type: 'offer',
    ),
    const NotificationEntity(
      id: '3',
      title: 'Payment Successful',
      body: 'We received your payment for order #12345.',
      time: '1 day ago',
      isRead: true,
      type: 'payment',
    ),
    const NotificationEntity(
      id: '4',
      title: 'Welcome Gift',
      body: 'Enjoy 10% off your first purchase. Use code WELCOME10.',
      time: '2 days ago',
      isRead: true,
      type: 'general',
    ),
  ];

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_notifications);
  }

  @override
  Future<void> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 300));
    for (var i = 0; i < _notifications.length; i++) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index >= 0) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }
}
