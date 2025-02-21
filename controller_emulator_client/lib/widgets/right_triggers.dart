import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
import 'package:flutter/material.dart';

class ShoulderButton extends StatefulWidget {
  final String text;
  final Function? onPressed;
  final Function? onRelease;
  final Icon? icon;
  const ShoulderButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.onRelease,
      this.icon});

  @override
  State<ShoulderButton> createState() => _ShoulderButtonState();
}

class _ShoulderButtonState extends State<ShoulderButton> {
  bool isPressed = false;

  void onPressed(_) {
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
    setState(() {
      isPressed = true;
    });
  }

  void onRelease(_) {
    if (widget.onRelease != null) {
      widget.onRelease!();
    }
    setState(() {
      isPressed = false;
    });
  }

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
          child: GestureDetector(
            onTapDown: onPressed,
            onTapUp: onRelease,
            onTapCancel: () => onRelease(null),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              color: isPressed ? Colors.white38 : Colors.transparent,
              child: (widget.icon == null)
                  ? Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white70,
                          backgroundColor: Colors.transparent,
                          height: 2),
                    )
                  : widget.icon!,
            ),
          )),
    );
  }
}

class RightTriggers extends StatefulWidget {
  const RightTriggers({super.key, required this.state});
  final ControllerState state;

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
            ShoulderButton(
                onPressed: () {
                  widget.state.trButton = true;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                onRelease: () {
                  widget.state.trButton = false;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                text: "R3"),
            ShoulderButton(
                onPressed: () {
                  widget.state.rtButton = true;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                onRelease: () {
                  widget.state.rtButton = false;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                text: "R2"),
            ShoulderButton(
                onPressed: () {
                  widget.state.rButton = true;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                onRelease: () {
                  widget.state.rButton = false;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                text: "R1"),
          ],
        ),
      ],
    );
  }
}
