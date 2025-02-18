import 'package:controller_emulator_client/handlers/udp_handler.dart';
import 'package:flutter/material.dart';

enum Connection {
  disconnected,
  trying,
  connected,
  error,
}

class ConnectionPageHandler {
  final ConnectionHandler connectionHandler;
  ConnectionPageHandler(this.connectionHandler);

  Future<Connection> tryConnection(Connection state) async {
    if (state != Connection.trying) {
      return Connection.disconnected;
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
