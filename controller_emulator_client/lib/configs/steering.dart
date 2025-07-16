import 'dart:async';
import 'dart:math' as math;
import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/types/controller_state.dart';
import 'package:flutter_rotation_sensor/flutter_rotation_sensor.dart';

enum SteeringState { disabled, leftStick, rightStick }

enum SteeringAxis { x, y, both }

class SteeringConfiguration {
  static var steeringState = SteeringState.disabled;
  static var steeringAxis = SteeringAxis.x;
  static var steeringSensitivity = 10.0;
}

class SteeringController {
  final double alpha;
  final ControllerState state;
  StreamSubscription<OrientationEvent>? _sub;
  var x = 0;
  var y = 0;

  SteeringController({this.alpha = 0.98, required this.state});

  void start() {
    RotationSensor.samplingPeriod = SensorInterval.normalInterval;
    _sub = RotationSensor.orientationStream.listen(_onOrientation);
  }

  void stop() {
    _sub?.cancel();
  }

  double radiansToDegrees(double radians) => radians * (180 / math.pi);
  double normalizeToRange(
    double value,
    double minIn,
    double maxIn,
    double minOut,
    double maxOut,
  ) {
    final clamped = value.clamp(minIn, maxIn);
    final normalized = (clamped - minIn) / (maxIn - minIn);
    return minOut + (normalized * (maxOut - minOut));
  }

  void _onOrientation(OrientationEvent e) {
    var pitch = radiansToDegrees(e.eulerAngles.pitch);
    var roll = radiansToDegrees(e.eulerAngles.roll);

    y = normalizeToRange(
            pitch * SteeringConfiguration.steeringSensitivity, -90, 90, 0, 99)
        .round();
    x = normalizeToRange(
            roll * SteeringConfiguration.steeringSensitivity, -90, 90, 0, 99)
        .round();

    if (SteeringConfiguration.steeringState == SteeringState.disabled) {
      stop();
      return;
    }

    if (SteeringConfiguration.steeringState == SteeringState.leftStick) {
      if (SteeringAxis.y == SteeringConfiguration.steeringAxis) {
        state.leftStickY = y;
        ConnectionPage.connection.updateRemoteXCMobi(state);
        return;
      }

      if (SteeringAxis.x == SteeringConfiguration.steeringAxis) {
        state.leftStickX = x;
        ConnectionPage.connection.updateRemoteXCMobi(state);
        return;
      }

      if (SteeringConfiguration.steeringAxis == SteeringAxis.both) {
        state.leftStickX = x;
        state.leftStickY = y;
        ConnectionPage.connection.updateRemoteXCMobi(state);
        return;
      }
    }

    if (SteeringConfiguration.steeringState == SteeringState.rightStick) {
      if (SteeringAxis.y == SteeringConfiguration.steeringAxis) {
        state.rightStickY = y;
        ConnectionPage.connection.updateRemoteXCMobi(state);
        return;
      }

      if (SteeringAxis.x == SteeringConfiguration.steeringAxis) {
        state.rightStickX = x;
        ConnectionPage.connection.updateRemoteXCMobi(state);
        return;
      }

      if (SteeringConfiguration.steeringAxis == SteeringAxis.both) {
        state.rightStickX = x;
        state.rightStickY = y;
        ConnectionPage.connection.updateRemoteXCMobi(state);
        return;
      }
    }
  }
}
