class ControllerState {
  bool aButton;
  bool bButton;
  bool xButton;
  bool yButton;
  bool startButton;
  bool selectButton;
  bool leftButton;
  bool rightButton;
  bool upButton;
  bool downButton;
  bool lButton;
  bool rButton;
  bool tlButton;
  bool trButton;
  bool ltButton;
  bool rtButton;
  int leftStickX;
  int leftStickY;
  int rightStickX;
  int rightStickY;

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
    this.leftStickX = 50,
    this.leftStickY = 50,
    this.rightStickX = 50,
    this.rightStickY = 50,
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
