//create product details page that takes from database the product details
//and show them
//
// Compare this snippet from lib/widget/product_widget.dart:
// // ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
//
// ignore_for_file: prefer_const_constructors

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//create product details page that takes from database the product details
//and show them
class listDetails extends StatelessWidget {
  final String documentId;
  final user = FirebaseAuth.instance.currentUser;
  //create array with button names

  int buttonClicked = 0;
  listDetails({required this.documentId});

  @override
  Widget build(BuildContext context) {
    List<String> listElementsID = [];

    //get data from Firestore
    Future getListElementsId() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection("liste")
          .doc(documentId)
          .collection("child")
          .get()
          .then((snapshot) => snapshot.docs.forEach((document) {
                listElementsID.add(document.reference.id);
              }));
    }

    return Scaffold(
      //section of product details, with big image on top and product details
      //below
      body: FutureBuilder(
          future: getListElementsId(),
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: listElementsID.length,
              //vertical align
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Text(listElementsID[index]);
              },
            );
          }),
    );
  }
}
