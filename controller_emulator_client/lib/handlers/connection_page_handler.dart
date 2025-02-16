import 'package:controller_emulator_client/handlers/udp_handler.dart';
import 'package:flutter/material.dart';

enum Connection {
  ignore,
  connected,
  error,
}

class ConnectionPageHandler {
  final ConnectionHandler connectionHandler;
  ConnectionPageHandler(this.connectionHandler);

  Future<Connection> handleConnection(bool tryingToConnect) async {
    if (!tryingToConnect) {
      return Connection.ignore;
    }
    try {
      final con = await connectionHandler.connect();
      if (con) {
        return Connection.connected;
      } else {
        return Connection.error;
      }
    } catch (e) {
      debugPrint(e.toString());
      return Connection.error;
    }
  }
}
