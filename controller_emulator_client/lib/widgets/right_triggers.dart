import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
import 'package:flutter/material.dart';

class ShoulderButton extends StatefulWidget {
  final String text;
  final double? size;
  final Function? onPressed;
  final Function? onRelease;
  final Icon? icon;
  const ShoulderButton(
      {super.key,
      this.size,
      required this.text,
      required this.onPressed,
      required this.onRelease,
      this.icon});

  @override
  State<ShoulderButton> createState() => _ShoulderButtonState();
}

class _ShoulderButtonState extends State<ShoulderButton> {
  final GlobalKey _key = GlobalKey();
  bool isPressed = false;

  void _handlePointerMove(PointerEvent event) {
    final RenderBox? box =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    final Offset topLeft = box.localToGlobal(Offset.zero);
    final Size size = box.size;
    final Rect bounds = topLeft & size;

    final bool nowInside = bounds.contains(event.position);

    if (!isPressed && nowInside) {
      widget.onPressed?.call();
      setState(() => isPressed = true);
    } else if (isPressed && !nowInside) {
      widget.onRelease?.call();
      setState(() => isPressed = false);
    }
  }

  void _handlePointerUp(PointerEvent event) {
    if (isPressed) {
      widget.onRelease?.call();
      setState(() => isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size ?? 100.0;

    return Listener(
      onPointerMove: _handlePointerMove,
      onPointerUp: _handlePointerUp,
      child: Container(
        color: Colors.transparent, // <- Important for making Listener work
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
                child: widget.icon ??
                    Text(
                      widget.text,
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
      ),
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
            ShoulderButton(
              size: 70,
              onPressed: () {
                widget.state.startButton = true;
                ConnectionPage.connection.updateRemoteXCMobi(widget.state);
              },
              onRelease: () {
                widget.state.startButton = false;
                ConnectionPage.connection.updateRemoteXCMobi(widget.state);
              },
              text: "Start",
              icon:
                  const Icon(Icons.play_arrow, color: Colors.white70, size: 32),
            ),
            const SizedBox(width: 40),
            ShoulderButton(
                size: 80,
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
                size: 80,
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
                size: 80,
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
