import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      routes: instanceRoutes(context),
      initialRoute: ConnectionPage.routeName,
    );
  }
}
