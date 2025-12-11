import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/constants/app_dimens.dart';

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
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.paddingLarge),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Shipping Address', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppDimens.paddingLarge),
            CustomTextField(
              controller: _addressController,
              label: 'Street Address',
              prefixIcon: AppIcons.address,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: AppDimens.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _cityController,
                    label: 'City',
                    prefixIcon: AppIcons.city,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: AppDimens.paddingMedium),
                Expanded(
                  child: CustomTextField(
                    controller: _zipController,
                    label: 'Zip Code',
                    prefixIcon: AppIcons.mapPin,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingLarge),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final fullAddress = '${_addressController.text}, ${_cityController.text} ${_zipController.text}';
                  widget.onAddressSelected(fullAddress);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, AppDimens.buttonHeight),
              ),
              child: const Text('Save & Continue'),
            ),
          ],
        ),
      ),
    );
}
