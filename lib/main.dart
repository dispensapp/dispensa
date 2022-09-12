import 'package:dispensa/provider/auth_page.dart';
import 'package:dispensa/provider/google_sign_in.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:dispensa/widget/sign_up_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'index.dart';
import 'package:dynamic_color/dynamic_color.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            ColorScheme lightColorScheme = lightDynamic ?? ColorScheme.light();
            ColorScheme darkColorScheme = darkDynamic ?? ColorScheme.dark();

            if (lightDynamic == null && darkDynamic == null) {
              lightColorScheme = ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                primaryColorDark: Colors.blue[900],
                accentColor: Colors.blueAccent,
                backgroundColor: Colors.white,
                cardColor: Colors.white,
                errorColor: Colors.redAccent,
                brightness: Brightness.light,
              );
              darkColorScheme = ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                primaryColorDark: Colors.blue[900],
                accentColor: Colors.blueAccent,
                backgroundColor: Colors.black,
                cardColor: Colors.black,
                errorColor: Colors.redAccent,
                brightness: Brightness.dark,
              );
            }

            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Dispensa',
                home: AuthPage(),
                theme: ThemeData(
                  fontFamily: 'roboto',
                  colorScheme: lightColorScheme,
                  useMaterial3: true,
                  primaryColor: PRIMARY_RED,
                ));
          },
        ),
      );
}
