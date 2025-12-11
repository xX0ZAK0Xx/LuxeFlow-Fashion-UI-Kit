import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/widgets/custom_text_field.dart';

class AddressScreen extends StatefulWidget {
  final Function(String) onAddressSelected;

  const AddressScreen({super.key, required this.onAddressSelected});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Shipping Address', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _addressController,
              label: 'Street Address',
              prefixIcon: PhosphorIcons.house(),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _cityController,
                    label: 'City',
                    prefixIcon: PhosphorIcons.buildings(),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    controller: _zipController,
                    label: 'Zip Code',
                    prefixIcon: PhosphorIcons.mapPin(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final fullAddress = '${_addressController.text}, ${_cityController.text} ${_zipController.text}';
                  widget.onAddressSelected(fullAddress);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Save & Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
