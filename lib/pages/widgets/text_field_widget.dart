import 'package:flutter/material.dart';
import '/core/constants.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final TextEditingController controller;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIconData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: greenColor,
        fontSize: 14.0,
      ),
      controller: controller,
      decoration: InputDecoration(
        focusColor: greenColor,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: greenColor),
        ),
        hintText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
        ),
      ),
    );
  }
}