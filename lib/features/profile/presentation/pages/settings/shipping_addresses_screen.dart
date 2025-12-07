import 'package:flutter/material.dart';
import '../../../../checkout/presentation/pages/address_screen.dart';

class ShippingAddressesScreen extends StatefulWidget {
  const ShippingAddressesScreen({super.key});

  @override
  State<ShippingAddressesScreen> createState() => _ShippingAddressesScreenState();
}

class _ShippingAddressesScreenState extends State<ShippingAddressesScreen> {
  final ValueNotifier<List<Map<String, dynamic>>> _addressesNotifier = ValueNotifier([
    {'label': 'Home', 'address': '123 Main St, New York, NY 10001', 'isDefault': true},
    {'label': 'Office', 'address': '456 Business Blvd, San Francisco, CA 94107', 'isDefault': false},
  ]);

  @override
  void dispose() {
    _addressesNotifier.dispose();
    super.dispose();
  }

  void _addAddress(String address) {
    final newAddress = {
      'label': 'New Address', // Simplify for now
      'address': address,
      'isDefault': false,
    };
    _addressesNotifier.value = [..._addressesNotifier.value, newAddress];
  }

  void _deleteAddress(int index) {
    final updatedList = List<Map<String, dynamic>>.from(_addressesNotifier.value);
    updatedList.removeAt(index);
    _addressesNotifier.value = updatedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shipping Addresses')),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: _addressesNotifier,
        builder: (context, addresses, _) {
          return addresses.isEmpty
              ? const Center(child: Text('No addresses found'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final item = addresses[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildAddressCard(
                        context,
                        item['label'],
                        item['address'],
                        item['isDefault'],
                        index,
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(title: const Text('Add Address')),
                body: AddressScreen(
                  onAddressSelected: (address) {
                    _addAddress(address);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, String label, String address, bool isDefault, int index) {
    return Dismissible(
      key: Key(address),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _deleteAddress(index),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.location_on_rounded, color: Colors.orange, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (isDefault) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, size: 20, color: Colors.grey[400]),
              onPressed: () => _deleteAddress(index),
            ),
          ],
        ),
      ),
    );
  }
}
