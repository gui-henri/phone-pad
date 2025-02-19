import 'package:controller_emulator_client/handlers/connection_page_handler.dart';
import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/widgets/left_stick.dart';
import 'package:controller_emulator_client/widgets/left_triggers.dart';
import 'package:controller_emulator_client/widgets/right_stick.dart';
import 'package:controller_emulator_client/widgets/right_triggers.dart';
import 'package:flutter/material.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});
  static const routeName = "/controller";

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        toolbarHeight: 32,
        backgroundColor: Colors.black38,
        title: const Text(
          "XC Mobi",
          style: TextStyle(color: Colors.white70),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white70,
          ),
          onPressed: () {
            ConnectionPage.connectionState = Connection.disconnected;
            Navigator.of(context).pushNamed("/connection");
            ConnectionPage.connection.disconnect();
          },
        ),
      ),
      body: const Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LeftTriggers(),
              RightTriggers(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LeftStick(),
              RightStick(),
            ],
          ),
        ],
      ),
    );
  }
}
