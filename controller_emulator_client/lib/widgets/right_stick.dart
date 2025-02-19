import 'package:controller_emulator_client/widgets/right_triggers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class RightStick extends StatefulWidget {
  const RightStick({super.key});

  @override
  State<RightStick> createState() => _RightStickState();
}

class _RightStickState extends State<RightStick> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 300,
      child: Stack(children: [
        Positioned(
          right: 40,
          top: 10,
          child: ShoulderButton(
            text: "X",
            onPressed: () {},
          ),
        ),
        Positioned(
          right: 112,
          top: 35,
          child: ShoulderButton(
            text: "Y",
            onPressed: () {},
          ),
        ),
        Positioned(
          right: 152,
          top: 98,
          child: ShoulderButton(
            text: "A",
            onPressed: () {},
          ),
        ),
        Positioned(
          right: 144,
          top: 171,
          child: ShoulderButton(
            text: "B",
            onPressed: () {},
          ),
        ),
        Positioned(
          bottom: 16,
          right: 0,
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
