import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
import 'package:controller_emulator_client/widgets/right_triggers.dart';
import 'package:flutter/material.dart';
import 'package:controller_emulator_client/configs/steering.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class RightStick extends StatefulWidget {
  const RightStick({super.key, required this.state});
  final ControllerState state;

  @override
  State<RightStick> createState() => _RightStickState();
}

class _RightStickState extends State<RightStick> {
  int _mapFromJoystick(double input) {
    return (((input + 1) * 99) / 2).toInt();
  }

  int lastX = 50;
  int lastY = 50;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 300,
      child: Stack(children: [
        // Positioned(
        //   right: 40,
        //   top: 10,
        //   child: ShoulderButton(
        //     text: "X",
        //     onPressed: () {
        //       widget.state.xButton = true;
        //       ConnectionPage.connection.updateRemoteXCMobi(widget.state);
        //     },
        //     onRelease: () {
        //       widget.state.xButton = false;
        //       ConnectionPage.connection.updateRemoteXCMobi(widget.state);
        //     },
        //   ),
        // ),
        // Positioned(
        //   right: 112,
        //   top: 35,
        //   child: ShoulderButton(
        //     text: "Y",
        //     onPressed: () {
        //       widget.state.yButton = true;
        //       ConnectionPage.connection.updateRemoteXCMobi(widget.state);
        //     },
        //     onRelease: () {
        //       widget.state.yButton = false;
        //       ConnectionPage.connection.updateRemoteXCMobi(widget.state);
        //     },
        //   ),
        // ),
        Positioned(
          right: 152,
          top: 98,
          child: ShoulderButton(
            text: "A",
            onPressed: () {
              widget.state.aButton = true;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
            onRelease: () {
              widget.state.aButton = false;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
          ),
        ),
        Positioned(
          right: 32,
          top: 64,
          child: ShoulderButton(
            text: "B",
            onPressed: () {
              widget.state.bButton = true;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
            onRelease: () {
              widget.state.bButton = false;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
          ),
        ),
        // Positioned(
        //   bottom: 16,
        //   right: 0,
        //   child: Joystick(
        //       base: JoystickBase(
        //         arrowsDecoration: JoystickArrowsDecoration(
        //           color: Colors.transparent,
        //         ),
        //         size: 150,
        //       ),
        //       stick: const JoystickStick(
        //         size: 100,
        //       ),
        //       listener: (details) {
        //         if (SteeringConfiguration.steeringState !=
        //             SteeringState.rightStick) {
        //           widget.state.rightStickX = _mapFromJoystick(details.x);
        //           widget.state.rightStickY = _mapFromJoystick(-details.y);
        //           if (lastX != widget.state.rightStickX ||
        //               lastY != widget.state.rightStickY) {
        //             lastX = widget.state.rightStickX;
        //             lastY = widget.state.rightStickY;
        //             ConnectionPage.connection.updateRemoteXCMobi(widget.state);
        //           }
        //           return;
        //         }

        //         if (SteeringAxis.x == SteeringConfiguration.steeringAxis) {
        //           widget.state.rightStickY = _mapFromJoystick(-details.y);
        //           if (lastY != widget.state.rightStickY) {
        //             lastY = widget.state.rightStickY;
        //             ConnectionPage.connection.updateRemoteXCMobi(widget.state);
        //           }
        //           return;
        //         }

        //         if (SteeringAxis.y == SteeringConfiguration.steeringAxis) {
        //           widget.state.leftStickY = _mapFromJoystick(details.x);
        //           if (lastY != widget.state.rightStickX) {
        //             lastY = widget.state.rightStickX;
        //             ConnectionPage.connection.updateRemoteXCMobi(widget.state);
        //           }
        //           return;
        //         }
        //       }),
        // ),
      ]),
    );
  }
}
