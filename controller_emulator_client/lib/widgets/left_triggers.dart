import 'package:controller_emulator_client/widgets/right_triggers.dart';
import 'package:flutter/material.dart';

class LeftTriggers extends StatefulWidget {
  const LeftTriggers({super.key});

  @override
  State<LeftTriggers> createState() => _LeftTriggersState();
}

class _LeftTriggersState extends State<LeftTriggers> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          spacing: 8,
          children: [
            ShoulderButton(onPressed: () {}, text: "L1"),
            ShoulderButton(onPressed: () {}, text: "L2"),
            ShoulderButton(onPressed: () {}, text: "L3"),
            const SizedBox(width: 40),
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
                    Icons.settings,
                    size: 32,
                    color: Colors.white70,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
