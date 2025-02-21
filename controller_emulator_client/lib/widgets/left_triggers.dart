import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
import 'package:controller_emulator_client/widgets/right_triggers.dart';
import 'package:flutter/material.dart';

class LeftTriggers extends StatefulWidget {
  const LeftTriggers({super.key, required this.state});
  final ControllerState state;
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
            ShoulderButton(
                onPressed: () {
                  widget.state.lButton = true;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                onRelease: () {
                  widget.state.lButton = false;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                text: "L1"),
            ShoulderButton(
                onPressed: () {
                  widget.state.ltButton = true;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                onRelease: () {
                  widget.state.ltButton = false;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                text: "L2"),
            ShoulderButton(
                onPressed: () {
                  widget.state.tlButton = true;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                onRelease: () {
                  widget.state.tlButton = false;
                  ConnectionPage.connection.updateRemoteXCMobi(widget.state);
                },
                text: "L3"),
            const SizedBox(width: 40),
            ShoulderButton(
              size: 56,
              onPressed: () {
                widget.state.selectButton = true;
                ConnectionPage.connection.updateRemoteXCMobi(widget.state);
              },
              onRelease: () {
                widget.state.selectButton = false;
                ConnectionPage.connection.updateRemoteXCMobi(widget.state);
              },
              text: "Select",
              icon: const Icon(Icons.settings, color: Colors.white70, size: 32),
            ),
          ],
        ),
      ],
    );
  }
}
