// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/widgets/custom_text_field.dart';

class PaymentScreen extends StatefulWidget {
  final VoidCallback onPaymentSuccess;

  const PaymentScreen({super.key, required this.onPaymentSuccess});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ValueNotifier<int> _selectedPaymentMethodNotifier = ValueNotifier(0); // 0: Card, 1: PayPal
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _selectedPaymentMethodNotifier.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

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
          // Card Details Form (Only if Card is selected)
          ValueListenableBuilder<int>(
            valueListenable: _selectedPaymentMethodNotifier,
            builder: (context, selectedPaymentMethod, _) {
              if (selectedPaymentMethod == 0) {
                return Column(
                  children: [
                    CustomTextField(
                      controller: _cardNumberController,
                      label: 'Card Number',
                      hintText: '0000 0000 0000 0000',
                      prefixIcon: PhosphorIcons.creditCard(),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _expiryController,
                            label: 'Expiry Date',
                            hintText: 'MM/YY',
                            prefixIcon: PhosphorIcons.calendarBlank(),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            controller: _cvvController,
                            label: 'CVV',
                            hintText: '123',
                            prefixIcon: PhosphorIcons.lockKey(),
                            keyboardType: TextInputType.number,
                            isPassword: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),

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
    return ValueListenableBuilder<int>(
      valueListenable: _selectedPaymentMethodNotifier,
      builder: (context, selectedPaymentMethod, _) {
        return RadioListTile<int>(
          value: value,
          groupValue: selectedPaymentMethod,
          onChanged: (int? newValue) {
            _selectedPaymentMethodNotifier.value = newValue!;
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
      },
    );
  }
}
