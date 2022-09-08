import 'package:flutter/material.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

//create product card in home page class

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //set shadow
      decoration: const BoxDecoration(
          color: PALETTE_WHITE,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.all(15),
      child: Column(children: [
        Image.asset('assets/images/test.png', width: 50),
        Text("Pan di stelle"),
        Container(
          padding: const EdgeInsets.all(7),
          margin: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
              color: PALETTE_LIGHT_YELLOW,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Text("20 FEB"),
        )
      ]),
    );
  }
}
