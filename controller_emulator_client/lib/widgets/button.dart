import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const Button({super.key, required this.text, required this.onPressed});
  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(),
      child: Text(widget.text),
    );
  }
}
