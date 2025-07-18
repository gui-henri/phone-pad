import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/types/controller_button.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
import 'package:flutter/material.dart';

class ControllerLayout {
  List<ControllerButton> buttons = [];
  final Map<String, bool> pressed = {};

  ControllerLayout(ControllerState state) {
    buttons = [
      ControllerButton(
          name: "Start",
          top: 15,
          right: 350,
          size: 70,
          icon: const Icon(
            Icons.play_arrow,
            color: Colors.white70,
            size: 36,
          ),
          onPress: () {
            pressed["Start"] = true;
            _updateState(state, () => state.startButton = true);
          },
          onRelease: () {
            pressed["Start"] = false;
            _updateState(state, () => state.startButton = false);
          },
          key: GlobalKey()),
      ControllerButton(
        name: "R3",
        top: 10,
        right: 10,
        size: 80,
        onPress: () {
          pressed["R3"] = true;
          _updateState(state, () => state.trButton = true);
        },
        onRelease: () {
          pressed["R3"] = false;
          _updateState(state, () => state.trButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "R2",
        top: 10,
        right: 100,
        size: 80,
        onPress: () {
          pressed["R2"] = true;
          _updateState(state, () => state.rtButton = true);
        },
        onRelease: () {
          pressed["R2"] = false;
          _updateState(state, () => state.rtButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "R1",
        top: 10,
        right: 190,
        size: 80,
        onPress: () {
          pressed["R1"] = true;
          _updateState(state, () => state.rButton = true);
        },
        onRelease: () {
          pressed["R1"] = false;
          _updateState(state, () => state.rButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "Up",
        top: 110,
        left: 270,
        size: 60,
        icon: const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white70,
          size: 36,
        ),
        onPress: () {
          pressed["Up"] = true;
          _updateState(state, () => state.upButton = true);
        },
        onRelease: () {
          pressed["Up"] = false;
          _updateState(state, () => state.upButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "Down",
        top: 190,
        left: 270,
        size: 60,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white70,
          size: 36,
        ),
        onPress: () {
          pressed["Down"] = true;
          _updateState(state, () => state.downButton = true);
        },
        onRelease: () {
          pressed["Down"] = false;
          _updateState(state, () => state.downButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "Left",
        top: 150,
        left: 230,
        size: 60,
        icon: const Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white70,
          size: 36,
        ),
        onPress: () {
          pressed["Left"] = true;
          _updateState(state, () => state.leftButton = true);
        },
        onRelease: () {
          pressed["Left"] = false;
          _updateState(state, () => state.leftButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "Right",
        top: 150,
        left: 310,
        size: 60,
        icon: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white70,
          size: 36,
        ),
        onPress: () {
          pressed["Right"] = true;
          _updateState(state, () => state.rightButton = true);
        },
        onRelease: () {
          pressed["Right"] = false;
          _updateState(state, () => state.rightButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "L1",
        top: 10,
        left: 190,
        size: 80,
        onPress: () {
          pressed["L1"] = true;
          _updateState(state, () => state.lButton = true);
        },
        onRelease: () {
          pressed["L1"] = false;
          _updateState(state, () => state.lButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "L2",
        top: 10,
        left: 100,
        size: 80,
        onPress: () {
          pressed["L2"] = true;
          _updateState(state, () => state.ltButton = true);
        },
        onRelease: () {
          pressed["L2"] = false;
          _updateState(state, () => state.ltButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "L3",
        top: 10,
        left: 10,
        size: 80,
        onPress: () {
          pressed["L3"] = true;
          _updateState(state, () => state.tlButton = true);
        },
        onRelease: () {
          pressed["L3"] = false;
          _updateState(state, () => state.tlButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "Select",
        top: 15,
        left: 350,
        size: 70,
        icon: const Icon(
          Icons.list,
          color: Colors.white70,
          size: 36,
        ),
        onPress: () {
          pressed["Select"] = true;
          _updateState(state, () => state.selectButton = true);
        },
        onRelease: () {
          pressed["Select"] = false;
          _updateState(state, () => state.selectButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "A",
        down: 30,
        right: 100,
        size: 90,
        onPress: () {
          pressed["A"] = true;
          _updateState(state, () => state.aButton = true);
        },
        onRelease: () {
          pressed["A"] = false;
          _updateState(state, () => state.aButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "B",
        down: 90,
        right: 30,
        size: 90,
        onPress: () {
          pressed["B"] = true;
          _updateState(state, () => state.bButton = true);
        },
        onRelease: () {
          pressed["B"] = false;
          _updateState(state, () => state.bButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "X",
        down: 90,
        right: 170,
        size: 90,
        onPress: () {
          pressed["X"] = true;
          _updateState(state, () => state.xButton = true);
        },
        onRelease: () {
          pressed["X"] = false;
          _updateState(state, () => state.xButton = false);
        },
        key: GlobalKey(),
      ),
      ControllerButton(
        name: "Y",
        down: 150,
        right: 100,
        size: 90,
        onPress: () {
          pressed["Y"] = true;
          _updateState(state, () => state.yButton = true);
        },
        onRelease: () {
          pressed["Y"] = false;
          _updateState(state, () => state.yButton = false);
        },
        key: GlobalKey(),
      ),
    ];
  }

  void _updateState(ControllerState state, Function action) {
    action();
    ConnectionPage.connection.updateRemoteXCMobi(state);
  }
}
