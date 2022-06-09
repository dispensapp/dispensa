import 'package:flutter/material.dart';
import 'index.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dispensa',
      home: MainPage(),
    );
  }
}
