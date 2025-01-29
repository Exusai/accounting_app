import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextInputType? textInputType;
  final void Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({super.key, required this.hint, this.onChanged, this.textInputType, this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
      ),
      keyboardType: textInputType,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
    );
  }
}