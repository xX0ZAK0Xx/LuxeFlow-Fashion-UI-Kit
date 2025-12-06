import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final notifications = [
      {
        'title': 'Order Shipped!',
        'body': 'Your order #12345 has been shipped and is on its way.',
        'time': '2 hours ago',
        'isRead': false,
        'icon': PhosphorIcons.truck(PhosphorIconsStyle.bold),
        'color': Colors.blue,
      },
      {
        'title': 'New Collection Alert',
        'body': 'Check out our new Winter Collection. Limited stock!',
        'time': '5 hours ago',
        'isRead': false,
        'icon': PhosphorIcons.tag(PhosphorIconsStyle.bold),
        'color': Colors.orange,
      },
      {
        'title': 'Payment Successful',
        'body': 'We received your payment for order #12345.',
        'time': '1 day ago',
        'isRead': true,
        'icon': PhosphorIcons.creditCard(PhosphorIconsStyle.bold),
        'color': Colors.green,
      },
      {
        'title': 'Welcome Gift',
        'body': 'Enjoy 10% off your first purchase. Use code WELCOME10.',
        'time': '2 days ago',
        'isRead': true,
        'icon': PhosphorIcons.gift(PhosphorIconsStyle.bold),
        'color': Colors.purple,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(PhosphorIcons.checks()),
            onPressed: () {},
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final n = notifications[index];
          final isRead = n['isRead'] as bool;

          return Container(
            decoration: BoxDecoration(
              color: isRead ? Colors.white : AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
              border: Border.all(
                color: isRead ? Colors.grey.shade200 : AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (n['color'] as Color).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            n['title'] as String,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isRead ? Colors.black87 : AppColors.primary,
                                ),
                          ),
                          Text(
                            n['time'] as String,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        n['body'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
