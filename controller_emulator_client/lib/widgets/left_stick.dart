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
    return (((input * SteeringConfiguration.steeringSensitivity + 1) * 99) / 2)
        .toInt();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 320,
      child: Stack(children: [
        Positioned(
          left: 230,
          top: 10,
          child: ShoulderButton(
            text: "Up",
            size: 50,
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
          left: 200,
          top: 45,
          child: ShoulderButton(
            text: "Left",
            size: 50,
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
          left: 260,
          top: 45,
          child: ShoulderButton(
            text: "Right",
            size: 50,
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
          left: 230,
          top: 80,
          child: ShoulderButton(
            text: "Down",
            size: 50,
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
          left: 32,
          child: Joystick(
              base: JoystickBase(
                arrowsDecoration: JoystickArrowsDecoration(
                  color: Colors.transparent,
                ),
                size: 180,
              ),
              stick: const JoystickStick(
                size: 150,
              ),
              listener: (details) {
                if (SteeringConfiguration.steeringState !=
                    SteeringState.leftStick) {
                  widget.state.leftStickX = _mapFromJoystick(details.x);
                  widget.state.leftStickY = _mapFromJoystick(-details.y);
                  if (lastX != widget.state.leftStickX ||
                      lastY != widget.state.leftStickY) {
                    lastX = widget.state.leftStickX;
                    lastY = widget.state.leftStickY;
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
                  widget.state.leftStickX = _mapFromJoystick(details.x);
                  if (lastX != widget.state.leftStickX) {
                    lastX = widget.state.leftStickX;
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
