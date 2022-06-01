import 'package:flutter/material.dart';

class TextFieldInputs extends StatelessWidget {
  const TextFieldInputs(
      {Key? key,
      required this.type,
      this.isPass = false,
      required this.editingController,
      required this.hintText})
      : super(key: key);
  final String hintText;
  final bool isPass;
  final TextInputType type;

  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: editingController,
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        hintText: hintText,
      ),
      keyboardType: type,
      obscureText: isPass,
    );
  }
}
