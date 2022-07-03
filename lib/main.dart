import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'index.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dispensa',
      home: MainPage(),
    );
  }
}
