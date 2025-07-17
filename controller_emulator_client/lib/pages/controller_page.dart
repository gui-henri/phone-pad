import 'package:controller_emulator_client/handlers/connection_page_handler.dart';
import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
// import 'package:controller_emulator_client/widgets/left_stick.dart';
// import 'package:controller_emulator_client/widgets/left_triggers.dart';
// import 'package:controller_emulator_client/widgets/right_stick.dart';
import 'package:controller_emulator_client/widgets/right_triggers.dart';
import 'package:controller_emulator_client/configs/layout.dart';
import 'package:flutter/material.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});
  static const routeName = "/controller";

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  var state = ControllerState();
  late final ControllerLayout layout = ControllerLayout(state);

  final Map<int, String> _pointerToButton = {};

  void _handlePointerEvent(PointerEvent event) {
    final pointer = event.pointer;
    String? currentBtn;
    for (final btn in layout.buttons) {
      final key = btn.key;
      if (key.currentContext == null) continue;
      final renderBox = key.currentContext!.findRenderObject() as RenderBox;
      final rect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      if (rect.contains(event.position)) {
        currentBtn = btn.name;
        break;
      }
    }

    final previousBtn = _pointerToButton[pointer];
    if (currentBtn != previousBtn) {
      // Saiu de um botão
      if (previousBtn != null) {
        final btn = layout.buttons.firstWhere((b) => b.name == previousBtn);
        btn.onRelease();
      }
      // Entrou em um novo botão
      if (currentBtn != null) {
        final btn = layout.buttons.firstWhere((b) => b.name == currentBtn);
        btn.onPress();
        _pointerToButton[pointer] = currentBtn;
      } else {
        _pointerToButton.remove(pointer);
      }
      setState(() {});
    }
  }

  void _handlePointerUp(PointerEvent event) {
    final pointer = event.pointer;
    final btnName = _pointerToButton[pointer];
    if (btnName != null) {
      final btn = layout.buttons.firstWhere((b) => b.name == btnName);
      btn.onRelease();
      _pointerToButton.remove(pointer);
      setState(() {});
    }
  }

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
      body: Listener(
        onPointerDown: _handlePointerEvent,
        onPointerMove: _handlePointerEvent,
        onPointerUp: _handlePointerUp,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: Stack(
            children: [
              for (final btn in layout.buttons)
                Positioned(
                  top: btn.top?.toDouble(),
                  left: btn.left?.toDouble(),
                  right: btn.right?.toDouble(),
                  bottom: btn.down?.toDouble(),
                  child: ShoulderButton(
                    isPressed: layout.pressed[btn.name] ?? false,
                    key: btn.key,
                    text: btn.name,
                    size: btn.size,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
