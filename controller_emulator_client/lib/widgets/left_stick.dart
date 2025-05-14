import 'package:controller_emulator_client/configs/steering.dart';
import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
import 'package:controller_emulator_client/widgets/right_triggers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class LeftStick extends StatefulWidget {
  const LeftStick({super.key, required this.state});
  final ControllerState state;

  @override
  State<LeftStick> createState() => LeftStickState();
}

class LeftStickState extends State<LeftStick> {
  int lastX = 50;
  int lastY = 50;
  late SteeringController steering;

  @override
  void initState() {
    super.initState();
    steering = SteeringController(
        alpha: SteeringConfiguration.steeringSensitivity, state: widget.state);

    if (SteeringConfiguration.steeringState == SteeringState.leftStick) {
      steering.start();
    }
  }

  int _mapFromJoystick(double input) {
    return (((input + 1) * 99) / 2).toInt();
  }

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
            onPressed: () {
              widget.state.upButton = true;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
            onRelease: () {
              widget.state.upButton = false;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
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
            onPressed: () {
              widget.state.leftButton = true;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
            onRelease: () {
              widget.state.leftButton = false;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
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
            onPressed: () {
              widget.state.rightButton = true;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
            onRelease: () {
              widget.state.rightButton = false;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
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
            onPressed: () {
              widget.state.downButton = true;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
            onRelease: () {
              widget.state.downButton = false;
              ConnectionPage.connection.updateRemoteXCMobi(widget.state);
            },
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
                if (SteeringConfiguration.steeringState !=
                    SteeringState.leftStick) {
                  widget.state.leftStickX = _mapFromJoystick(details.x);
                  widget.state.leftStickY = _mapFromJoystick(-details.y);
                  if (lastX != widget.state.leftStickX ||
                      lastY != widget.state.leftStickX) {
                    lastX = widget.state.leftStickX;
                    lastY = widget.state.leftStickX;
                    ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                  }
                  return;
                }

                if (SteeringAxis.x == SteeringConfiguration.steeringAxis) {
                  widget.state.leftStickY = _mapFromJoystick(-details.y);
                  if (lastY != widget.state.leftStickY) {
                    lastY = widget.state.leftStickY;
                    ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                  }
                  return;
                }

                if (SteeringAxis.y == SteeringConfiguration.steeringAxis) {
                  widget.state.leftStickY = _mapFromJoystick(details.x);
                  if (lastY != widget.state.leftStickY) {
                    lastY = widget.state.leftStickY;
                    ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                  }
                  return;
                }
              }),
        ),
      ]),
    );
  }
}
