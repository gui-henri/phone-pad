import 'package:controller_emulator_client/handlers/connection_page_handler.dart';
import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:flutter/material.dart';

import '../types/connection_arguments.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});
  static const routeName = "/controller";

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as ConnectionArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("XC Mobi"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            args.connectionHandler.disconnect();
            ConnectionPage.connectionState = Connection.disconnected;
            Navigator.of(context).pop();
          },
          child: const Text("Back"),
        ),
      ),
    );
  }
}
