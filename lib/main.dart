import 'package:appconf_second/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double textScale
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 32.0,
          ),
          subtitle: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
        ),
      ),
      home: HomePage(),
    );
  }
}
