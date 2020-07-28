import 'package:budget/home.dart';
import 'styles.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget planning',
      theme: ThemeData(
        fontFamily: Styles.mainFont,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home()
    );
  }
}
