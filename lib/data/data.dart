import 'package:appconf_second/model/gamepad.dart';
import 'package:flutter/material.dart';

class Data {
  static const String _description =
      'The DualShock®4 Wireless Controller for PlayStation®4 defines this generation of play, combining revolutionary features and comfort with intuitive, precision controls. Evolved analog sticks and trigger buttons allow for unparalleled accuracy with every move while innovative technologies offer exciting ways to experience your games and share your greatest moments.';

  static List<Gamepad> pads = [
    Gamepad(
        name: 'MAGMA RED',
        type: 'DualShock 4',
        price: 64.0,
        color: Colors.red,
        image: 'images/red-front.png',
        description: _description),
    Gamepad(
        name: 'WAVE BLUE',
        type: 'DualShock 4',
        price: 54.0,
        color: Colors.blue,
        image: 'images/blue-front.png',
        description: _description),
  ];
}
