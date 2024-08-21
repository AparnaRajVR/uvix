import 'package:flutter/material.dart';

class ProductTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final type;

  const ProductTextFieldWidget({
    required this.controller,
    required this.labelText,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type == true ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
