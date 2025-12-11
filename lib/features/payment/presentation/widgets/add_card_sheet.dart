import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/widgets/custom_text_field.dart';

class AddCardSheet extends StatefulWidget {
  final ScrollController scrollController;
  final Function(String number, String expiry, String type, String holder) onAddCard;

  const AddCardSheet({
    super.key,
    required this.scrollController,
    required this.onAddCard,
  });

  @override
  State<AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<AddCardSheet> {
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _holderController = TextEditingController();
  final ValueNotifier<String> _typeNotifier = ValueNotifier('Visa');

  // For card preview updates
  final ValueNotifier<String> _numberNotifier = ValueNotifier('');
  final ValueNotifier<String> _expiryNotifier = ValueNotifier('');
  final ValueNotifier<String> _holderNotifier = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    _numberController.addListener(() => _numberNotifier.value = _numberController.text);
    _expiryController.addListener(() => _expiryNotifier.value = _expiryController.text);
    _holderController.addListener(() => _holderNotifier.value = _holderController.text);
  }

  @override
  void dispose() {
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _holderController.dispose();
    _typeNotifier.dispose();
    _numberNotifier.dispose();
    _expiryNotifier.dispose();
    _holderNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              children: [
                Text(
                  'Add New Card',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Visual Card Preview
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blue.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade900.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(PhosphorIcons.contactlessPayment(), color: Colors.white70),
                          ValueListenableBuilder<String>(
                            valueListenable: _typeNotifier,
                            builder: (context, type, _) {
                              return Text(
                                type,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      ValueListenableBuilder<String>(
                        valueListenable: _numberNotifier,
                        builder: (context, number, _) {
                          return Text(
                            number.isEmpty ? '**** **** **** ****' : number,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 2,
                              fontFamily: 'Courier',
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('CARD HOLDER', style: TextStyle(color: Colors.white60, fontSize: 10)),
                              ValueListenableBuilder<String>(
                                valueListenable: _holderNotifier,
                                builder: (context, holder, _) {
                                  return Text(
                                    holder.isEmpty ? 'YOUR NAME' : holder.toUpperCase(),
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('EXPIRES', style: TextStyle(color: Colors.white60, fontSize: 10)),
                              ValueListenableBuilder<String>(
                                valueListenable: _expiryNotifier,
                                builder: (context, expiry, _) {
                                  return Text(
                                    expiry.isEmpty ? 'MM/YY' : expiry,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Form Fields
                CustomTextField(
                  controller: _holderController,
                  label: 'Card Holder Name',
                  prefixIcon: PhosphorIcons.user(),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _numberController,
                  label: 'Card Number',
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
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        controller: _cvvController,
                        label: 'CVV',
                        prefixIcon: PhosphorIcons.lockKey(),
                        isPassword: true,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_numberController.text.isNotEmpty) {
                      widget.onAddCard(
                        _numberController.text,
                        _expiryController.text,
                        _typeNotifier.value,
                        _holderController.text,
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Add Card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
