import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udp/udp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(const ControllerEmulator());
}

class ControllerEmulator extends StatelessWidget {
  const ControllerEmulator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Controller Emulator'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool shouldSend = false;
  bool isConnected = false;
  String ip = "";
  int port = 0;

  void defineTimer() {
    setState(() {
      shouldSend = !shouldSend;

      Timer.periodic(const Duration(seconds: 1), (timer) async {
        final msgs = ["CONNECT"];

        if (shouldSend) {
          var udp = await UDP.bind(Endpoint.any(port: const Port(65000)));
          var len = await udp.send(
              msgs[0].codeUnits, Endpoint.broadcast(port: const Port(4321)));
          debugPrint("Sent $len bytes");
          udp.asStream(timeout: const Duration(seconds: 2)).listen((datagram) {
            if (datagram == null) {
              return;
            }
            if (String.fromCharCodes(datagram.data) != "IP_FOUND") {
              return;
            }

            ip = datagram.address.address;
            port = datagram.port;
            isConnected = true;
            shouldSend = false;
            debugPrint("Connected to: $ip:$port");
          });
        }

        if (!shouldSend) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: !isConnected,
              child: ElevatedButton(
                  onPressed: defineTimer,
                  child: Text(shouldSend ? "Stop" : "Start")),
            ),
            Visibility(
              visible: isConnected,
              child: Column(
                children: [
                  const Text("Connected Controller Emulator"),
                  ElevatedButton(
                    onPressed: () async {
                      var udp =
                          await UDP.bind(Endpoint.any(port: const Port(65000)));
                      var len = await udp.send(
                          "~BA11111112874712~".codeUnits,
                          Endpoint.unicast(InternetAddress(ip),
                              port: Port(port)));
                      debugPrint("Sent $len bytes");

                      Timer(const Duration(seconds: 3), () async {
                        var len = await udp.send(
                            "~0000000050505050~".codeUnits,
                            Endpoint.unicast(InternetAddress(ip),
                                port: Port(port)));
                        debugPrint("Sent $len bytes");
                        udp.close();
                        isConnected = false;
                      });
                    },
                    child: const Text("Press A"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
