import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final String? Function(String?) validator;
  final VoidCallback? onChanged; // ✅ Callback when user types

  const CustomTextInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    required this.validator,
    this.onChanged, // ✅ Receive function to reset validation
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Colors.grey), // Default border color
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.orange), // Border color when focused
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.grey), // Border color when enabled
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.red), // Border color when error
            ),
          ),
          validator: validator,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(); // ✅ Reset validation when typing
            }
          },
        ),
      ],
    );
  }
}
