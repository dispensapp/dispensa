// ignore_for_file: prefer_const_constructors

import 'package:dispensa/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: PALETTE_WHITE,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Column(children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 200,
                    ),
                    Text(
                      'Accedi o Registrati',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'utilizzando il tasto qui sotto!',
                      style: TextStyle(fontSize: 20),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.all(50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: PALETTE_BLUE,
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity, 50)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(width: 10),
                          Icon(FontAwesomeIcons.google, color: Colors.white),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10), //apply padding to some sides only
                            child: Text("Sign In"),
                          ),
                        ]),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                  ),
                )
              ],
            )));
  }
}
