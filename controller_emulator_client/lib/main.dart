import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udp/udp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Controller Emulator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool shouldSend = false;
  void defineTimer() {
    setState(() {
      shouldSend = !shouldSend;

      Timer.periodic(const Duration(seconds: 3), (timer) async {
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

            var ip = datagram.address.address;
            var port = datagram.port;
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
            ElevatedButton(
                onPressed: defineTimer,
                child: Text(shouldSend ? "Stop" : "Start")),
          ],
        ),
      ),
    );
  }
}
