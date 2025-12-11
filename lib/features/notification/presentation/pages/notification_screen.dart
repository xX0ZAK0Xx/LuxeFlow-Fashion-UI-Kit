import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../domain/entities/notification_entity.dart';
import '../blocs/notification_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(AppIcons.checks),
            onPressed: () {
               context.read<NotificationBloc>().add(MarkAllAsReadEvent());
            },
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(child: Text('No notifications'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final n = state.notifications[index];
                return _buildNotificationCard(context, n);
              },
            );
          } else if (state is NotificationError) {
             return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );

  Widget _buildNotificationCard(BuildContext context, NotificationEntity n) {
      Color iconColor;
      IconData iconData;

      switch (n.type) {
        case 'shipping':
          iconColor = Colors.blue;
          iconData = AppIcons.truck;
          break;
        case 'offer':
          iconColor = Colors.orange;
          iconData = AppIcons.tag;
          break;
        case 'payment':
          iconColor = Colors.green;
          iconData = AppIcons.creditCard;
          break;
        case 'general':
        default:
          iconColor = Colors.purple;
          iconData = AppIcons.gift;
          break;
      }
      
      return GestureDetector(
        onTap: () {
           if (!n.isRead) {
             context.read<NotificationBloc>().add(MarkAsReadEvent(n.id));
           }
        },
        child: Container(
            decoration: BoxDecoration(
              color: n.isRead 
                  ? Theme.of(context).cardColor 
                  : Theme.of(context).primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
              border: Border.all(
                color: n.isRead 
                    ? Theme.of(context).dividerColor.withValues(alpha: 0.1)
                    : Theme.of(context).primaryColor.withValues(alpha: 0.2),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              n.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: n.isRead ? FontWeight.w400 : FontWeight.w700,
                                    color: n.isRead 
                                        ? Theme.of(context).textTheme.bodyLarge?.color 
                                        : Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                          Text(
                            n.time,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        n.body,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      );
  }
}
