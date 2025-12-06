// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final VoidCallback onPaymentSuccess;

  const PaymentScreen({super.key, required this.onPaymentSuccess});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0; // 0: Card, 1: PayPal

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Payment Method', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          
          // Payment Options
          _buildPaymentOption(0, 'Credit Card', Icons.credit_card),
          const SizedBox(height: 16),
          _buildPaymentOption(1, 'PayPal', Icons.payment),
           const SizedBox(height: 16),
          _buildPaymentOption(2, 'Apple Pay', Icons.apple),

          const SizedBox(height: 32),
          
          // Card Details Form (Only if Card is selected)
          if (_selectedPaymentMethod == 0) ...[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Card Number',
                hintText: '0000 0000 0000 0000',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date',
                      hintText: 'MM/YY',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      hintText: '123',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: widget.onPaymentSuccess,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 54),
              backgroundColor: Colors.black, // Use theme/primary color appropriately in real app
              foregroundColor: Colors.white,
            ),
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(int value, String title, IconData icon) {
    return RadioListTile<int>(
      value: value,
      groupValue: _selectedPaymentMethod,
      onChanged: (int? newValue) {
        setState(() {
          _selectedPaymentMethod = newValue!;
        });
      },
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 16),
          Text(title),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      tileColor: Theme.of(context).cardColor,
    );
  }
}
