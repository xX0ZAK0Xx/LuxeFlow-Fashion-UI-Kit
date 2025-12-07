import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  final ValueNotifier<bool> _orderUpdatesNotifier = ValueNotifier(true);
  final ValueNotifier<bool> _promotionsNotifier = ValueNotifier(true);
  final ValueNotifier<bool> _newArrivalsNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _orderUpdatesNotifier.dispose();
    _promotionsNotifier.dispose();
    _newArrivalsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: ListView(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: _orderUpdatesNotifier,
            builder: (context, value, _) {
              return SwitchListTile(
                title: const Text('Order Updates'),
                subtitle: const Text('Get notified about your order status'),
                value: value,
                onChanged: (val) => _orderUpdatesNotifier.value = val,
              );
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _promotionsNotifier,
            builder: (context, value, _) {
              return SwitchListTile(
                title: const Text('Promotions'),
                subtitle: const Text('Receive offers and discounts'),
                value: value,
                onChanged: (val) => _promotionsNotifier.value = val,
              );
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _newArrivalsNotifier,
            builder: (context, value, _) {
              return SwitchListTile(
                title: const Text('New Arrivals'),
                subtitle: const Text('Be the first to know about new products'),
                value: value,
                onChanged: (val) => _newArrivalsNotifier.value = val,
              );
            },
          ),
        ],
      ),
    );
  }
}
