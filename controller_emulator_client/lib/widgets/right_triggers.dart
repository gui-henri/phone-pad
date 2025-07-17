import 'package:flutter/material.dart';

class ShoulderButton extends StatelessWidget {
  final String text;
  final bool isPressed;
  final double? size;
  final Icon? icon;
  ShoulderButton(
      {super.key,
      this.size,
      required this.text,
      required this.isPressed,
      this.icon});

  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: ClipOval(
          child: Container(
            key: _key,
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(color: Colors.white70, width: 4.0),
              ),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              color: isPressed ? Colors.white38 : Colors.transparent,
              alignment: Alignment.center,
              child: icon ??
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white70,
                      height: 2,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
