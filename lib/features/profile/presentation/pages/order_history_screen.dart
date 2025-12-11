import 'package:flutter/material.dart';
import 'order_details_screen.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_colors.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Orders
    final orders = [
      {'id': '#12345', 'date': 'Dec 12, 2023', 'status': 'Delivered', 'total': '\$120.00', 'statusColor': AppColors.success},
      {'id': '#12346', 'date': 'Dec 15, 2023', 'status': 'Processing', 'total': '\$85.50', 'statusColor': AppColors.warning},
      {'id': '#12347', 'date': 'Dec 20, 2023', 'status': 'Cancelled', 'total': '\$45.00', 'statusColor': AppColors.error},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppDimens.paddingMedium),
        itemCount: orders.length,
        separatorBuilder: (context, index) => const SizedBox(height: AppDimens.paddingMedium),
        itemBuilder: (context, index) {
          final order = orders[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailsScreen(order: order),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: AppDimens.paddingSmall), 
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              padding: const EdgeInsets.all(AppDimens.p24), 
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ${order['id']}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: AppDimens.p4),
                           Text(
                            order['date'] as String,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textLightSecondary),
                           ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppDimens.radiusMedium, vertical: 6),
                        decoration: BoxDecoration(
                          color: (order['statusColor'] as Color).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          order['status'] as String,
                          style: TextStyle(
                            color: order['statusColor'] as Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppDimens.paddingMedium),
                    child: Divider(height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(index + 2)} Items', // Mock items count
                         style: const TextStyle(color: AppColors.textLightSecondary, fontSize: 13),
                      ),
                      Text(
                        order['total'] as String,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold, 
                            color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
