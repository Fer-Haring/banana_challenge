import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomFormFieldInput extends ConsumerWidget {
  final TextEditingController controller;
  final bool isPassword;
  final bool isPasswordVisible;
  final String labelText;
  final String? Function(String?)? validator;
  final bool showPasswordToggle;
  final VoidCallback? onTogglePasswordVisibility;

  const CustomFormFieldInput({
    super.key,
    required this.controller,
    this.isPassword = false,
    this.isPasswordVisible = false,
    required this.labelText,
    this.validator,
    this.showPasswordToggle = false,
    this.onTogglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      style: const TextStyle(color: Color(0xFF4F4F4F)),
      validator: validator,
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Theme.of(context).shadowColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
        filled: true,
        fillColor: Theme.of(context).shadowColor.withOpacity(0.06),
        suffixIcon: showPasswordToggle
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: onTogglePasswordVisibility,
              )
            : null,
      ),
    );
  }
}
