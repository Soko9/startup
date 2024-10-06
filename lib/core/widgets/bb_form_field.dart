import 'package:flutter/material.dart';

class BBFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final String? Function(String? value)? validator;

  const BBFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.all(3.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        obscuringCharacter: "○",
        validator: validator,
        style: const TextStyle(
          fontSize: 18.0,
        ),
        cursorColor: Theme.of(context).textTheme.bodyLarge!.color,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          hintText: hint.toUpperCase(),
          hintStyle: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          errorStyle: TextStyle(
            fontSize: 12.0,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          contentPadding: const EdgeInsets.all(12.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
