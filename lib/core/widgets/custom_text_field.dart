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
    this.textInputAction = TextInputAction.next,
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
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
      valueListenable: _isFocusedNotifier,
      builder: (context, isFocused, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label.isNotEmpty) ...[
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
              ),
              const SizedBox(height: 8),
            ],
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ValueListenableBuilder<bool>(
                valueListenable: _obscureTextNotifier,
                builder: (context, obscureText, _) => TextFormField(
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
                      hintText: widget.hintText,
                      hintStyle: TextStyle(color: Colors.grey[500]),
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
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
              ),
            ),
          ],
        ),
    );
}
