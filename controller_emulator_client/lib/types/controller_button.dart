import 'package:flutter/material.dart';

class ControllerButton {
  final String name;
  final int? top;
  final int? left;
  final int? right;
  final int? down;
  final double size;
  final GlobalKey key;
  final Function onPress;
  final Function onRelease;

  ControllerButton({
    required this.name,
    this.top,
    this.left,
    this.right,
    this.down,
    required this.size,
    required this.onPress,
    required this.onRelease,
    required this.key,
  });
}
