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
  final ValueNotifier<int> _currentStepNotifier = ValueNotifier(0);
  // String? _shippingAddress;

  @override
  void dispose() {
    _currentStepNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ValueListenableBuilder<int>(
        valueListenable: _currentStepNotifier,
        builder: (context, currentStep, _) => Stepper(
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepTapped: (index) {
              // Only allow tapping back or if moving forward sequentially (validation needed in real app)
              if (index < currentStep) {
                _currentStepNotifier.value = index;
              }
            },
            controlsBuilder: (context, details) => const SizedBox.shrink(),
            steps: [
              Step(
                title: const Text('Address'),
                content: AddressScreen(
                  onAddressSelected: (address) {
                    // _shippingAddress = address;
                    _currentStepNotifier.value = 1;
                  },
                ),
                isActive: currentStep >= 0,
                state: currentStep > 0 ? StepState.complete : StepState.editing,
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
                isActive: currentStep >= 1,
                state: currentStep == 1 ? StepState.editing : StepState.disabled, // Only active when step 1
              ),
            ],
          ),
      ),
    );
}
