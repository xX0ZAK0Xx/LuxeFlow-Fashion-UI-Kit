import 'package:flutter/material.dart';

class OrderTimeline extends StatelessWidget {
  final String status;
  final Map<String, String>? dates;

  const OrderTimeline({super.key, required this.status, this.dates});

  @override
  Widget build(BuildContext context) {
    const steps = ['Order Placed', 'Processing', 'Shipped', 'Delivered'];
    int currentStep = 0;
    
    // Simple status mapping
    if (status == 'Processing') currentStep = 1;
    if (status == 'Shipped') currentStep = 2;
    if (status == 'Delivered') currentStep = 3;
    if (status == 'Cancelled') currentStep = -1;

    if (currentStep == -1) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
             Icon(Icons.cancel, color: Colors.red),
             SizedBox(width: 12),
             Text('Order Cancelled', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    return Column(
      children: List.generate(steps.length, (index) {
        final isCompleted = index <= currentStep;
        final isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isCompleted ? Theme.of(context).primaryColor : Colors.grey[300],
                    shape: BoxShape.circle,
                    border: isCompleted ? null : Border.all(color: Colors.grey[400]!),
                  ),
                  child: isCompleted 
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: index < currentStep ? Theme.of(context).primaryColor : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2), // Align text with circle
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[index],
                      style: TextStyle(
                        fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                        color: isCompleted ? Theme.of(context).textTheme.bodyLarge?.color : Theme.of(context).disabledColor,
                      ),
                    ),
                    if (isCompleted)
                       Padding(
                         padding: const EdgeInsets.only(top: 4, bottom: 20),
                         child: Text(
                           dates?[steps[index]] ?? 'Completed', 
                           style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color),
                         ),
                       )
                    else 
                       const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
