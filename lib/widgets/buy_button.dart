import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const buttonColor = Colors.green;

    return OutlineButton(
      borderSide: BorderSide(color: buttonColor, width: 1.5),
      shape: StadiumBorder(),
      child: Container(
        child: Text(
          'BUY',
          style: TextStyle(color: buttonColor),
          textAlign: TextAlign.center,
        ),
        width: 150.0,
      ),
      onPressed: () {},
    );
  }
}
