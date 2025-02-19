import 'package:flutter/material.dart';

class ShoulderButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Icon? icon;
  const ShoulderButton(
      {super.key, required this.text, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
          width: 70.0,
          height: 70.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.fromBorderSide(
                BorderSide(color: Colors.white70, width: 4.0)),
          ),
          child: IconButton(
            highlightColor: Colors.white38,
            color: Colors.transparent,
            onPressed: onPressed,
            icon: (icon == null)
                ? Text(
                    text,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white70,
                      backgroundColor: Colors.transparent,
                    ),
                  )
                : icon!,
          )),
    );
  }
}

class RightTriggers extends StatefulWidget {
  const RightTriggers({super.key});

  @override
  State<RightTriggers> createState() => _RightTriggersState();
}

class _RightTriggersState extends State<RightTriggers> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          spacing: 8,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.fromBorderSide(
                    BorderSide(color: Colors.white70, width: 4.0)),
              ),
              child: IconButton(
                  highlightColor: Colors.white38,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 32,
                    color: Colors.white70,
                  )),
            ),
            const SizedBox(width: 40),
            ShoulderButton(onPressed: () {}, text: "R3"),
            ShoulderButton(onPressed: () {}, text: "R2"),
            ShoulderButton(onPressed: () {}, text: "R1"),
          ],
        ),
      ],
    );
  }
}
