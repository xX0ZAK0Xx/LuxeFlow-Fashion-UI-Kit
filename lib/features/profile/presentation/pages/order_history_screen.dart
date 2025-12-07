import 'package:flutter/material.dart';
import 'order_details_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Orders
    final orders = [
      {'id': '#12345', 'date': 'Dec 12, 2023', 'status': 'Delivered', 'total': '\$120.00', 'statusColor': Colors.green},
      {'id': '#12346', 'date': 'Dec 15, 2023', 'status': 'Processing', 'total': '\$85.50', 'statusColor': Colors.orange},
      {'id': '#12347', 'date': 'Dec 20, 2023', 'status': 'Cancelled', 'total': '\$45.00', 'statusColor': Colors.red},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
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
              margin: const EdgeInsets.only(bottom: 8), 
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              padding: const EdgeInsets.all(20), 
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
                          const SizedBox(height: 4),
                           Text(
                            order['date'] as String,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                           ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(index + 2)} Items', // Mock items count
                         style: const TextStyle(color: Colors.grey, fontSize: 13),
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
