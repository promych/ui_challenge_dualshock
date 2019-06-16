import 'package:appconf_second/data/data.dart';
import 'package:appconf_second/model/gamepad.dart';
import 'package:appconf_second/widgets/card.dart';
import 'package:appconf_second/widgets/dots_indicator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Gamepad> pads;
  PageController controller;
  Animatable<Color> background;
  static const kDuration = const Duration(milliseconds: 300);
  static const kCurve = Curves.ease;
  double pageOffset = 0.0;

  @override
  void initState() {
    pads = Data.pads;
    background = TweenSequence<Color>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: pads.first.color,
          end: pads.last.color,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: pads.last.color,
          end: pads.first.color,
        ),
      ),
    ]);
    controller = PageController(initialPage: 0);
    controller.addListener(() {
      setState(() => pageOffset = controller.page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              final color = controller.hasClients
                  ? controller.page / Data.pads.length
                  : 0.0;
              return DecoratedBox(
                decoration: BoxDecoration(
                    color: background.evaluate(AlwaysStoppedAnimation(color))),
                child: child,
              );
            },
            child: PageView.builder(
              controller: controller,
              itemCount: pads.length,
              itemBuilder: (BuildContext context, int index) {
                return CardPage(
                  pad: pads[index],
                  offset: pageOffset - index,
                );
              },
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: DotsIndicator(
                  controller: controller,
                  itemCount: pads.length,
                  onPageSelected: (int page) {
                    controller.animateToPage(
                      page,
                      duration: kDuration,
                      curve: kCurve,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
