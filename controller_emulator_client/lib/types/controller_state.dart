class ControllerState {
  final bool aButton;
  final bool bButton;
  final bool xButton;
  final bool yButton;
  final bool startButton;
  final bool selectButton;
  final bool leftButton;
  final bool rightButton;
  final bool upButton;
  final bool downButton;
  final bool lButton;
  final bool rButton;
  final bool tlButton;
  final bool trButton;
  final bool ltButton;
  final bool rtButton;
  final int leftStickX;
  final int leftStickY;
  final int rightStickX;
  final int rightStickY;

  ControllerState({
    this.aButton = false,
    this.bButton = false,
    this.xButton = false,
    this.yButton = false,
    this.startButton = false,
    this.selectButton = false,
    this.leftButton = false,
    this.rightButton = false,
    this.upButton = false,
    this.downButton = false,
    this.lButton = false,
    this.rButton = false,
    this.tlButton = false,
    this.trButton = false,
    this.ltButton = false,
    this.rtButton = false,
    this.leftStickX = 0,
    this.leftStickY = 0,
    this.rightStickX = 0,
    this.rightStickY = 0,
  });

  List<int> toXCMobiCode() {
    var initialCode = "~";
    initialCode += _buttonPairToCode(aButton, bButton);
    initialCode += _buttonPairToCode(xButton, yButton);
    initialCode += _buttonPairToCode(startButton, selectButton);
    initialCode += _buttonPairToCode(leftButton, rightButton);
    initialCode += _buttonPairToCode(upButton, downButton);
    initialCode += _buttonPairToCode(lButton, rButton);
    initialCode += _buttonPairToCode(tlButton, trButton);
    initialCode += _buttonPairToCode(ltButton, rtButton);
    initialCode += _axisToCode(leftStickX);
    initialCode += _axisToCode(leftStickY);
    initialCode += _axisToCode(rightStickX);
    initialCode += _axisToCode(rightStickY);
    initialCode += "~";
    return initialCode.codeUnits;
  }

  String _buttonPairToCode(bool first, bool second) {
    if (first && second) {
      return "1";
    } else if (first && !second) {
      return "A";
    } else if (!first && second) {
      return "B";
    } else {
      return "0";
    }
  }

  String _axisToCode(int axis) {
    if (axis < 0) {
      return "00";
    } else if (axis > 99) {
      return "99";
    } else {
      return axis.toString().padLeft(2, "0");
    }
  }
}
