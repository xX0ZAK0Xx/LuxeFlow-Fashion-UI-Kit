import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _orderUpdates = true;
  bool _promotions = true;
  bool _newArrivals = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Order Updates'),
            subtitle: const Text('Get notified about your order status'),
            value: _orderUpdates,
            onChanged: (val) => setState(() => _orderUpdates = val),
          ),
          SwitchListTile(
            title: const Text('Promotions'),
            subtitle: const Text('Receive offers and discounts'),
            value: _promotions,
            onChanged: (val) => setState(() => _promotions = val),
          ),
          SwitchListTile(
            title: const Text('New Arrivals'),
            subtitle: const Text('Be the first to know about new products'),
            value: _newArrivals,
            onChanged: (val) => setState(() => _newArrivals = val),
          ),
        ],
      ),
    );
  }
}
