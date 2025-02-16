import 'package:controller_emulator_client/handlers/connection_page_handler.dart';
import 'package:controller_emulator_client/handlers/udp_handler.dart';
import 'package:controller_emulator_client/types/connection_arguments.dart';
import 'package:flutter/material.dart';
import 'package:udp/udp.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});
  static const routeName = "/connection";
  static var udp = UDP.bind(Endpoint.any(port: const Port(4322)));
  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  bool tryingToConnect = false;
  @override
  void dispose() {
    ConnectionPage.udp.then((value) => value.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ConnectionPage.udp,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          final ConnectionHandler connectionHandler =
              ConnectionHandler(snapshot.data!);
          final connectionPageHandler =
              ConnectionPageHandler(connectionHandler);

          final conn = connectionPageHandler.handleConnection(tryingToConnect);
          return FutureBuilder(
              future: conn,
              builder: (context, connSnapshot) {
                void handleConnection() {
                  setState(() {
                    tryingToConnect = !tryingToConnect;
                  });
                }

                if (connSnapshot.connectionState == ConnectionState.done) {
                  if (connSnapshot.data! == Connection.connected) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamed(context, "/controller",
                          arguments: ConnectionArguments(
                              connectionHandler: connectionHandler));
                    });
                  }
                }

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    title: const Text("XC-Mobi"),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: handleConnection,
                            child: connSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? const Text("Connecting...")
                                : const Text("Start")),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
