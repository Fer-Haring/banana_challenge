import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomFormFieldInput extends ConsumerWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String labelText;
  final String? Function(String?)? validator;

  const CustomFormFieldInput({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Color(0xFF4F4F4F)),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor complete este campo';
            }
            return null;
          },
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Theme.of(context).shadowColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
        filled: true,
        fillColor: Theme.of(context).shadowColor.withOpacity(0.06),
      ),
    );
  }
}
