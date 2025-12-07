import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffix;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final bool autofocus;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.isPassword = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.autofocus = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier(true);
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _isFocusedNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      _isFocusedNotifier.value = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _obscureTextNotifier.dispose();
    _isFocusedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isFocusedNotifier,
      builder: (context, isFocused, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isFocused ? Theme.of(context).primaryColor : Colors.grey.withValues(alpha: 0.2),
                  width: isFocused ? 2 : 1,
                ),
                boxShadow: isFocused
                    ? [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: ValueListenableBuilder<bool>(
                valueListenable: _obscureTextNotifier,
                builder: (context, obscureText, _) {
                  return TextFormField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    obscureText: widget.isPassword && obscureText,
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    onFieldSubmitted: widget.onSubmitted,
                    onChanged: widget.onChanged,
                    validator: widget.validator,
                    autofocus: widget.autofocus,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      labelText: widget.label,
                      hintText: widget.hintText,
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        color: isFocused ? Theme.of(context).primaryColor : Colors.grey[600],
                        fontWeight: isFocused ? FontWeight.w600 : FontWeight.normal,
                      ),
                      prefixIcon: widget.prefixIcon != null
                          ? Icon(
                              widget.prefixIcon,
                              color: isFocused ? Theme.of(context).primaryColor : Colors.grey[400],
                            )
                          : null,
                      suffixIcon: widget.suffix ??
                          (widget.isPassword
                              ? IconButton(
                                  icon: Icon(
                                    obscureText ? PhosphorIcons.eye() : PhosphorIcons.eyeSlash(),
                                    color: Colors.grey[400],
                                  ),
                                  onPressed: () {
                                    _obscureTextNotifier.value = !obscureText;
                                  },
                                )
                              : (widget.suffixIcon != null
                                  ? Icon(widget.suffixIcon, color: Colors.grey[400])
                                  : null)),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Validator error placement (TextFormField handles this mostly, but our container wraps it. 
            // If the validator fails, the error text shows INSIDE the container with InputBorder.none? 
            // Actually InputBorder.none usually suppresses error text. 
            // Wait, default helperText/errorText appears below the input area. 
            // With InputBorder.none, it should still appear if there's space. 
            // Let's test this. Usually standard Flutter TextFormField draws error below line. 
            // Since we wrapped it in a Container, the error will be inside the container? No.
            // The Container wraps the TextFormField.
            // So if `errorText` is generated, it will expand the Container height if inside.
            // Or we might need to rely on the TextFormField's built-in error display which might look weird inside a box.
            // A common pattern for "Custom Box" fields is to set errorStyle: height: 0 and show validation error manually below.
            // Or just let it render inside. Let's stick to standard behavior for now and see.)
          ],
        );
      },
    );
  }
}
