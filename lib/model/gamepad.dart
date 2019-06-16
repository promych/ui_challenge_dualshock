import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Gamepad {
  final String name;
  final String type;
  final double price;
  final MaterialColor color;
  final String image;
  final String description;

  Gamepad(
      {@required this.name,
      @required this.type,
      @required this.price,
      @required this.color,
      @required this.image,
      this.description});
}
