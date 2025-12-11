import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../widgets/order_timeline.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ${order['id']}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDimens.p4),
                    Text('${order['date']}', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.radiusMedium, vertical: 6),
                  decoration: BoxDecoration(
                    color: (order['statusColor'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${order['status']}',
                    style: TextStyle(color: order['statusColor'] as Color, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingLarge),

            // Timeline
            Text('Order Status', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: AppDimens.paddingMedium),
            OrderTimeline(
              status: order['status'],
              dates: const {
                'Order Placed': 'Oct 24, 10:30 AM',
                'Processing': 'Oct 25, 09:15 AM',
                'Shipped': 'Oct 26, 02:45 PM',
                'Delivered': 'Oct 28, 11:20 AM',
              },
            ),
            const SizedBox(height: AppDimens.p32),

            // Items
            Text('Items', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: AppDimens.paddingMedium),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2, // Mock 2 items
              itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppDimens.paddingMedium),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
                        child: CachedNetworkImage(
                          imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=200',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: AppDimens.paddingMedium),
                      Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text('Modern Fashion Item', style: TextStyle(fontWeight: FontWeight.bold)),
                             const SizedBox(height: AppDimens.p4),
                             Text('Size: M  •  Color: Black', style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color)),
                           ],
                         ),
                      ),
                      const Text('\$45.00', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
            ),
            const Divider(height: AppDimens.p32),

            // Shipping & Payment
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Shipping Address', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: AppDimens.paddingSmall),
                      Text('Jane Doe\n123 Main St\nNew York, NY 10001', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
                    ],
                  ),
                ),
                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: AppDimens.paddingSmall),
                      Text('Visa ending 1234', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.p32),

            // Summary
            Container(
              padding: const EdgeInsets.all(AppDimens.paddingMedium),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Subtotal'), Text('\$90.00')],
                  ),
                  const SizedBox(height: AppDimens.paddingSmall),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Shipping'), Text('\$15.00')],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(order['total'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).primaryColor)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
