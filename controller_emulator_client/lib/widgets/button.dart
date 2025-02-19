import 'package:flutter/material.dart';

class ButtonPad extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const ButtonPad({super.key, required this.text, required this.onPressed});
  @override
  State<ButtonPad> createState() => _ButtonPadState();
}

class _ButtonPadState extends State<ButtonPad> {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Text(widget.text));
  }
}
