import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;

  const CustomTextField({Key? key, this.hintText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: 12,
      maxLines: null,
      decoration: InputDecoration(
          hintText: hintText ?? "Enter your input here ...",
          border: const OutlineInputBorder(),
      ),
    );
  }
}
