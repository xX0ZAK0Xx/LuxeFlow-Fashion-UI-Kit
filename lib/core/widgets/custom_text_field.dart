import 'package:flutter/material.dart';
import '../constants/app_icons.dart';

import '../constants/app_dimens.dart';
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
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
              ),
              const SizedBox(height: AppDimens.paddingSmall),
            ],
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).inputDecorationTheme.fillColor ?? Theme.of(context).disabledColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
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
                      hintStyle: TextStyle(color: Theme.of(context).hintColor),
                      prefixIcon: widget.prefixIcon != null
                          ? Icon(
                              widget.prefixIcon,
                              color: isFocused ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                            )
                          : null,
                      suffixIcon: widget.suffix ??
                          (widget.isPassword
                              ? IconButton(
                                  icon: Icon(
                                    obscureText ? AppIcons.eye : AppIcons.eyeSlash,
                                    color: Theme.of(context).disabledColor,
                                  ),
                                  onPressed: () {
                                    _obscureTextNotifier.value = !obscureText;
                                  },
                                )
                              : (widget.suffixIcon != null
                                  ? Icon(widget.suffixIcon, color: Theme.of(context).disabledColor)
                                  : null)),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.paddingMedium,
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
