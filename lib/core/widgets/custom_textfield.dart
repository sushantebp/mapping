import 'package:flutter/material.dart';
import 'package:mapping/core/core.dart';

/// Minimal customizable TextFormField
class CustomTextField extends StatefulWidget {
  final String? placeholder;
  final String? label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool enabled;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final bool isPassword;
  final Function(String)? onChanged;
  final String? initialValue;
  final bool isRounded;
  final Function(String)? onFieldSubmitted;

  final bool showClearButtonOnTyping;

  const CustomTextField({
    super.key,
    this.placeholder,
    this.label,
    this.controller,
    this.enabled = true,
    this.validator,
    this.prefix,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.onChanged,
    this.initialValue,
    this.isRounded = false,
    this.onFieldSubmitted,
    this.showClearButtonOnTyping = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final ValueNotifier<bool> _obsecureTextNotifier;
  late final ValueNotifier<bool> _showClearNotifier;

  TextEditingController get _effectiveController =>
      widget.controller ?? TextEditingController();

  @override
  void initState() {
    _obsecureTextNotifier = ValueNotifier<bool>(widget.isPassword);
    _showClearNotifier = ValueNotifier<bool>(false);
    super.initState();
    if (widget.showClearButtonOnTyping) {
      _effectiveController.addListener(() {
        _showClearNotifier.value = _effectiveController.text.isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    _obsecureTextNotifier.dispose();
    _showClearNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface),
      borderRadius: BorderRadius.circular(
        widget.isRounded ? AppSize.radiusLarge * 3 : AppSize.radiusLarge,
      ),
    );

    return ValueListenableBuilder<bool>(
      valueListenable: _obsecureTextNotifier,
      builder: (context, obsecureText, _) {
        Widget? suffixWidget;

        if (widget.isPassword) {
          suffixWidget =
              widget.suffix ??
              IconButton(
                onPressed: () {
                  _obsecureTextNotifier.value = !_obsecureTextNotifier.value;
                },
                icon: Icon(
                  obsecureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              );
        } else if (widget.showClearButtonOnTyping) {
          suffixWidget = ValueListenableBuilder<bool>(
            valueListenable: _showClearNotifier,
            builder: (context, showClear, __) {
              if (showClear) {
                return IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _effectiveController.clear();
                    // Optionally reset clear button visibility immediately
                    _showClearNotifier.value = false;
                    // Optionally notify onChanged with empty string
                    if (widget.onChanged != null) widget.onChanged!('');
                  },
                );
              } else {
                return widget.suffix ?? SizedBox.shrink();
              }
            },
          );
        } else {
          suffixWidget = widget.suffix;
        }

        return TextFormField(
          controller: widget.controller,
          initialValue: widget.initialValue,
          enabled: widget.enabled,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? obsecureText : false,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            filled: true,
            labelText: widget.label,
            hintText: widget.placeholder,
            prefixIcon: widget.prefix,
            suffixIcon: suffixWidget,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border,
          ),
        );
      },
    );
  }
}
