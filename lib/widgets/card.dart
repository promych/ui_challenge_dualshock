import 'dart:math' as math;

import 'package:appconf_second/model/gamepad.dart';
import 'package:appconf_second/screens/details.dart';
import 'package:appconf_second/widgets/buy_button.dart';
import 'package:appconf_second/widgets/scale_transition.dart';
import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  final Gamepad pad;
  final double offset;

  const CardPage({Key key, @required this.pad, @required this.offset});

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));

    return GestureDetector(
      child: CardContent(
        pad: pad,
        offset: Offset(-80 * gauss * offset.sign, 0),
      ),
      onTap: () {
        Navigator.of(context).push(ScaleRoute(page: DetailsPage(pad: pad)));
      },
    );
  }
}

class CardContent extends StatelessWidget {
  final Gamepad pad;
  final Offset offset;

  const CardContent({Key key, @required this.pad, @required this.offset});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 40.0, vertical: screenHeight / 8),
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[800],
                blurRadius: 20.0,
              )
            ],
            color: Colors.white,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 40.0,
                  child: Text(
                    pad.name,
                    style: Theme.of(context).textTheme.title,
                  )),
              Positioned(
                  top: 100.0,
                  child: Transform.translate(
                    offset: offset,
                    child: Text(
                      '\u0024${pad.price}',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  )),
              Center(
                child: Transform.translate(
                  offset: offset,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.65),
                    child: Hero(
                      tag: pad.name,
                      child: Image.asset(
                        pad.image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(bottom: 80.0, child: BuyButton()),
              Positioned(
                bottom: 40.0,
                child: Transform.translate(
                  offset: offset,
                  child: Text(
                    '${pad.type}',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
