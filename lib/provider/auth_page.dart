// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, camel_case_types, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import '../utils/constants.dart';
import '../widget/sign_up_widget.dart';
import '../page/home_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          return MainPage();
        } else {
          return SignUpWidget();
        }
      },
    ));
  }
}
