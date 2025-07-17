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
          top: 10,
          right: 0,
          size: 70,
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
        top: 80,
        left: 10,
        size: 70,
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
        top: 160,
        left: 10,
        size: 70,
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
        top: 240,
        left: 10,
        size: 70,
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
    ];
  }

  void _updateState(ControllerState state, Function action) {
    action();
    ConnectionPage.connection.updateRemoteXCMobi(state);
  }
}
