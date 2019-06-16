import 'dart:math';

import 'package:appconf_second/model/gamepad.dart';
import 'package:appconf_second/widgets/buy_button.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Gamepad pad;

  const DetailsPage({Key key, @required this.pad}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  Animation animationBounce, animationScale;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animationBounce = Tween(begin: -0.1, end: 0.0).animate(CurvedAnimation(
      curve: Curves.bounceInOut,
      parent: animationController,
    ));
    animationScale = Tween(begin: -0.5, end: 0.0).animate(CurvedAnimation(
      curve: Curves.elasticInOut,
      parent: animationController,
    ));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    animationController.forward();

    return Scaffold(
      body: GestureDetector(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return Stack(children: [
                Positioned(
                  top: -100.0,
                  child: Hero(
                    tag: widget.pad.name,
                    child: Transform.rotate(
                      angle: -pi,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: screenWidth),
                        child: Image.asset(widget.pad.image),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: screenHeight / 4,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          animationBounce.value * screenWidth, 0.0, 0.0),
                      child: Container(
                        width: screenWidth,
                        child: Text(
                          widget.pad.name,
                          style: TextStyle(
                            fontSize: screenHeight / 7,
                            color: widget.pad.color[100],
                            fontWeight: FontWeight.bold,
                            height: 0.6,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  top: screenHeight / 2,
                  right: 40.0,
                  left: 40.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.pad.type,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Wireless Controller',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(widget.pad.description,
                          textScaleFactor: screenHeight / 1000),
                    ],
                  ),
                ),
                Positioned(
                  bottom: screenHeight / 6,
                  child: Container(
                    width: screenWidth,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BuyButton(),
                        Text(
                          '\u0024${widget.pad.price}',
                          style: Theme.of(context).textTheme.title,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, animationBounce.value * 100, 0.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: 150.0, maxWidth: screenWidth),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'images/black-back.png',
                                height: 100.0,
                                width: screenWidth / 3,
                              ),
                              Image.asset(
                                'images/black-angle.png',
                                width: screenWidth / 3,
                              ),
                              Image.asset(
                                'images/black-front.png',
                                height: 100.0,
                                width: screenWidth / 3,
                              ),
                            ]),
                      ),
                    ),
                  ),
                )
              ]);
            },
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
