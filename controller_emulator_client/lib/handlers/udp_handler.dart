import 'dart:async';
import 'dart:io';

import 'package:controller_emulator_client/handlers/connection_page_handler.dart';
import 'package:controller_emulator_client/types/connection_listenner.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
import 'package:udp/udp.dart';

class ConnectionHandler {
  Connection connection = Connection.disconnected;
  String _ip = "";
  int _port = 0;
  static var _udp = UDP.bind(Endpoint.any(port: const Port(4322)));
  static Future<UDP> get udp async {
    var udpInstance = await _udp;
    if (udpInstance.closed) {
      _udp = UDP.bind(Endpoint.any(port: const Port(4322)));
      udpInstance = await _udp;
    }
    return udpInstance;
  }

  static const messageConnect = "CONNECT";
  List<ConnectionListener> listeners = [];

  ConnectionHandler();

  set connected(Connection state) {
    connection = state;
    if (connection == Connection.connected) {
      for (var listener in listeners) {
        listener.onConnected();
      }
    } else if (connection == Connection.disconnected) {
      for (var listener in listeners) {
        listener.onDisconnected();
      }
    }
  }

  void dispose() {
    udp.then((value) => value.close());
  }

  void addListener(ConnectionListener listener) {
    listeners.add(listener);
  }

  bool removeListener(ConnectionListener listener) {
    return listeners.remove(listener);
  }

  void removeListennerById(int id) {
    listeners.removeWhere((element) => element.id == id);
  }

  Future<bool> connect() async {
    final udpInstance = await udp;

    while (connection != Connection.connected) {
      try {
        final completer = Completer<void>();
        await udpInstance.send(messageConnect.codeUnits,
            Endpoint.broadcast(port: const Port(4321)));

        udpInstance.asStream(timeout: const Duration(seconds: 1)).listen(
          (datagram) {
            if (datagram == null) return;
            if (String.fromCharCodes(datagram.data) != "IP_FOUND") return;

            _ip = datagram.address.address;
            _port = datagram.port;
            connection = Connection.connected;

            completer.complete();
          },
          onDone: () {
            if (!completer.isCompleted) completer.complete();
          },
        );

        await completer.future;

        if (connection != Connection.connected) {
          await Future.delayed(const Duration(seconds: 2));
        }
      } catch (e) {
        return false;
      }
    }

    return true;
  }

  Future<void> updateRemoteXCMobi(ControllerState state) async {
    if (connection != Connection.connected || _ip == "" || _port == 0) {
      return;
    }

    final udpInstance = await udp;
    await udpInstance.send(state.toXCMobiCode(),
        Endpoint.unicast(InternetAddress(_ip), port: Port(_port)));
  }

  Future<void> disconnect() async {
    if (connection != Connection.connected || _ip == "" || _port == 0) {
      return;
    }
    final udpInstance = await udp;
    await udpInstance.send("R".codeUnits,
        Endpoint.unicast(InternetAddress(_ip), port: Port(_port)));
    connection = Connection.disconnected;
    _ip = "";
    _port = 0;
  }
}
