import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.p32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(AppIcons.success, size: 120, color: AppColors.success),
              const SizedBox(height: AppDimens.paddingLarge),
              Text(
                'Order Placed Successfully!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.paddingMedium),
              const Text(
                'Thank you for your purchase. Your order will be delivered soon.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textLightSecondary),
              ),
              const SizedBox(height: AppDimens.p48),
              ElevatedButton(
                onPressed: () {
                   Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, AppDimens.buttonHeight),
                ),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
}
