// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';

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
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Payment Method', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppDimens.paddingLarge),
          
          // Payment Options
          _buildPaymentOption(0, 'Credit Card', AppIcons.card),
          const SizedBox(height: AppDimens.paddingMedium),
          _buildPaymentOption(1, 'PayPal', AppIcons.payment),
           const SizedBox(height: AppDimens.paddingMedium),
          _buildPaymentOption(2, 'Apple Pay', AppIcons.brandApple),

          const SizedBox(height: AppDimens.p32),
          
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
                      prefixIcon: AppIcons.creditCard,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: AppDimens.paddingMedium),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _expiryController,
                            label: 'Expiry Date',
                            hintText: 'MM/YY',
                            prefixIcon: AppIcons.calendar,
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        const SizedBox(width: AppDimens.paddingMedium),
                        Expanded(
                          child: CustomTextField(
                            controller: _cvvController,
                            label: 'CVV',
                            hintText: '123',
                            prefixIcon: AppIcons.password,
                            keyboardType: TextInputType.number,
                            isPassword: true,
                            textInputAction: TextInputAction.done,
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

          const SizedBox(height: AppDimens.p32),
          ElevatedButton(
            onPressed: widget.onPaymentSuccess,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, AppDimens.buttonHeight),
              backgroundColor: AppColors.primary, // Use theme/primary color appropriately in real app
              foregroundColor: AppColors.textDarkPrimary,
            ),
            child: const Text('Place Order'),
          ),
        ],
      ),
    );

  Widget _buildPaymentOption(int value, String title, IconData icon) => ValueListenableBuilder<int>(
      valueListenable: _selectedPaymentMethodNotifier,
      builder: (context, selectedPaymentMethod, _) => RadioListTile<int>(
          value: value,
          groupValue: selectedPaymentMethod,
          onChanged: (int? newValue) {
            _selectedPaymentMethodNotifier.value = newValue!;
          },
          title: Row(
            children: [
              Icon(icon),
              const SizedBox(width: AppDimens.paddingMedium),
              Text(title),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
            side: BorderSide(color: Theme.of(context).dividerColor),
          ),
          tileColor: Theme.of(context).cardColor,
        ),
    );
}
