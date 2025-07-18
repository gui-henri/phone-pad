import 'package:controller_emulator_client/configs/steering.dart';
import 'package:controller_emulator_client/handlers/connection_page_handler.dart';
import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
import 'package:controller_emulator_client/widgets/right_triggers.dart';
import 'package:controller_emulator_client/configs/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});
  static const routeName = "/controller";

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int lastXLeft = 50;
  int lastYLeft = 50;
  int lastXRight = 50;
  int lastYRight = 50;

  var state = ControllerState();
  late final ControllerLayout layout = ControllerLayout(state);

  final Map<int, String> _pointerToButton = {};

  int _mapFromJoystick(double input) {
    return (((input * SteeringConfiguration.steeringSensitivity + 1) * 99) / 2)
        .toInt();
  }

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
      if (previousBtn != null) {
        final btn = layout.buttons.firstWhere((b) => b.name == previousBtn);
        btn.onRelease();
      }
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
                    icon: btn.icon,
                  ),
                ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Joystick(
                    base: JoystickBase(
                      arrowsDecoration: JoystickArrowsDecoration(
                        color: Colors.transparent,
                      ),
                      size: 180,
                    ),
                    stick: const JoystickStick(
                      size: 150,
                    ),
                    listener: (details) {
                      int x = _mapFromJoystick(details.x);
                      int y = _mapFromJoystick(-details.y);
                      if (SteeringConfiguration.steeringState !=
                          SteeringState.leftStick) {
                        if (lastXLeft != x || lastYLeft != y) {
                          lastXLeft = x;
                          lastYLeft = y;
                          state.leftStickX = x;
                          state.leftStickY = y;
                          ConnectionPage.connection.updateRemoteXCMobi(state);
                        }
                        return;
                      }

                      if (SteeringConfiguration.steeringAxis ==
                          SteeringAxis.x) {
                        if (lastYLeft != y) {
                          lastYLeft = y;
                          state.leftStickY = y;
                          ConnectionPage.connection.updateRemoteXCMobi(state);
                        }
                        return;
                      }

                      if (SteeringConfiguration.steeringAxis ==
                          SteeringAxis.y) {
                        if (lastXLeft != x) {
                          lastXLeft = x;
                          state.leftStickX = x;
                          ConnectionPage.connection.updateRemoteXCMobi(state);
                        }
                        return;
                      }
                    }),
              ),
              Positioned(
                bottom: 16,
                right: 300,
                child: Joystick(
                  base: JoystickBase(
                    arrowsDecoration: JoystickArrowsDecoration(
                      color: Colors.transparent,
                    ),
                    size: 100,
                  ),
                  stick: const JoystickStick(
                    size: 75,
                  ),
                  listener: (details) {
                    int x = _mapFromJoystick(details.x);
                    int y = _mapFromJoystick(-details.y);

                    if (SteeringConfiguration.steeringState !=
                        SteeringState.rightStick) {
                      if (lastXRight != x || lastYRight != y) {
                        lastXRight = x;
                        lastYRight = y;
                        state.rightStickX = x;
                        state.rightStickY = y;
                        ConnectionPage.connection.updateRemoteXCMobi(state);
                      }
                      return;
                    }

                    if (SteeringConfiguration.steeringAxis == SteeringAxis.x) {
                      if (lastYRight != y) {
                        lastYRight = y;
                        state.rightStickY = y;
                        ConnectionPage.connection.updateRemoteXCMobi(state);
                      }
                      return;
                    }

                    if (SteeringConfiguration.steeringAxis == SteeringAxis.y) {
                      if (lastXRight != x) {
                        lastXRight = x;
                        state.rightStickX = x;
                        ConnectionPage.connection.updateRemoteXCMobi(state);
                      }
                      return;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
