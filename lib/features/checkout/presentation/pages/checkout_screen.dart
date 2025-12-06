import 'package:flutter/material.dart';
import 'address_screen.dart';
import 'payment_screen.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  // String? _shippingAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepTapped: (index) {
          // Only allow tapping back or if moving forward sequentially (validation needed in real app)
          if (index < _currentStep) {
            setState(() => _currentStep = index);
          }
        },
        controlsBuilder: (context, details) {
          return const SizedBox.shrink(); // Hide default buttons, we use custom ones inside screens
        },
        steps: [
          Step(
            title: const Text('Address'),
            content: AddressScreen(
              onAddressSelected: (address) {
                setState(() {
                  // _shippingAddress = address;
                  _currentStep = 1;
                });
              },
            ),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.editing,
          ),
          Step(
            title: const Text('Payment'),
            content: PaymentScreen(
              onPaymentSuccess: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
                );
              },
            ),
            isActive: _currentStep >= 1,
            state: _currentStep == 1 ? StepState.editing : StepState.disabled, // Only active when step 1
          ),
        ],
      ),
    );
  }
}
