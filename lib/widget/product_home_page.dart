// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = FirebaseDatabase.instance
    .ref("users/${FirebaseAuth.instance.currentUser!.uid.toString()}/dispensa");

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});
  Future<List<String>> getDocId() async {
    List<String> dataIDs = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection("dispensa")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print("ciao ${document.reference.id}");
            }));
    return dataIDs;
  }

  @override
  Widget build(BuildContext context) {
    //read each element in dispensa collection

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
