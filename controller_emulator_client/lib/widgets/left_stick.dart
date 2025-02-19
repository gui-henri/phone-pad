import 'package:controller_emulator_client/widgets/right_triggers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class LeftStick extends StatefulWidget {
  const LeftStick({super.key});

  @override
  State<LeftStick> createState() => _LeftStickState();
}

class _LeftStickState extends State<LeftStick> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 300,
      child: Stack(children: [
        Positioned(
          left: 40,
          top: 10,
          child: ShoulderButton(
            text: "Up",
            onPressed: () {},
            icon: const Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white70,
              size: 36,
            ),
          ),
        ),
        Positioned(
          left: 112,
          top: 35,
          child: ShoulderButton(
            text: "Left",
            onPressed: () {},
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white70,
              size: 36,
            ),
          ),
        ),
        Positioned(
          left: 152,
          top: 98,
          child: ShoulderButton(
            text: "Right",
            onPressed: () {},
            icon: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white70,
              size: 36,
            ),
          ),
        ),
        Positioned(
          left: 144,
          top: 171,
          child: ShoulderButton(
            text: "Down",
            onPressed: () {},
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white70,
              size: 36,
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          child: Joystick(
              base: JoystickBase(
                arrowsDecoration: JoystickArrowsDecoration(
                  color: Colors.transparent,
                ),
                size: 150,
              ),
              stick: const JoystickStick(
                size: 100,
              ),
              listener: (details) {
                debugPrint(details.x.toString());
                debugPrint(details.y.toString());
              }),
        ),
      ]),
    );
  }
}
