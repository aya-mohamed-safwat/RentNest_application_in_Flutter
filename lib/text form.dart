import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType keyboard;
  final IconData x;
  IconData? y;
  final void Function()? onPressed;
  bool obscure = false;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validation;

  var style;

  MyTextForm({
    Key? key,
    required this.title,
    required this.keyboard,
    required this.x,
    required this.style,
    this.controller,
    this.y,
    required this.obscure,
    this.onChanged,
    this.validation,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscure,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(x),
        suffixIcon: IconButton(onPressed: onPressed, icon: Icon(y)),
      ),
      validator: validation,
    );
  }
}