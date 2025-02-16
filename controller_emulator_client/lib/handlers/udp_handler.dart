import 'dart:async';
import 'dart:io';

import 'package:controller_emulator_client/types/connection_listenner.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
import 'package:udp/udp.dart';

class ConnectionHandler {
  bool isConnected = false;
  String _ip = "";
  int _port = 0;
  UDP _udp;
  Future<UDP> get udp async {
    if (_udp.closed) {
      _udp = await UDP.bind(Endpoint.any(port: const Port(4322)));
    }
    return _udp;
  }

  static const messageConnect = "CONNECT";
  List<ConnectionListener> listeners = [];

  ConnectionHandler(this._udp);

  set connected(bool value) {
    isConnected = value;
    if (isConnected) {
      for (var listener in listeners) {
        listener.onConnected();
      }
    } else {
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

    while (!isConnected) {
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
            isConnected = true;

            completer.complete();
          },
          onDone: () {
            if (!completer.isCompleted) completer.complete();
          },
        );

        await completer.future;

        if (!isConnected) {
          await Future.delayed(const Duration(seconds: 2));
        }
      } catch (e) {
        return false;
      }
    }

    return true;
  }

  Future<void> updateRemoteXCMobi(ControllerState state) async {
    if (!isConnected || _ip == "" || _port == 0) {
      return;
    }

    final udpInstance = await udp;
    await udpInstance.send(state.toXCMobiCode(),
        Endpoint.unicast(InternetAddress(_ip), port: Port(_port)));
  }

  Future<void> disconnect() async {
    if (!isConnected || _ip == "" || _port == 0) {
      return;
    }
    final udpInstance = await udp;
    await udpInstance.send("R".codeUnits,
        Endpoint.unicast(InternetAddress(_ip), port: Port(_port)));
    isConnected = false;
  }
}
