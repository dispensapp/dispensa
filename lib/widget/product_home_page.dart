// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class productCard extends StatelessWidget {
  final String documentId;
  final user = FirebaseAuth.instance.currentUser;

  productCard({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference productsData = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("dispensa");

    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        decoration: BoxDecoration(color: PALETTE_WHITE),
        child: FutureBuilder<DocumentSnapshot>(
          future: productsData.doc(documentId).get(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/test.png', width: 50),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${data['name']}",
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .apply(fontSizeFactor: 1.5)),
                            Text("${data['expirationDate']}")
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [Text("${data['number']}"), Text("pz")],
                      ))
                ],
              );
            }
            return Text("Loading");
          }),
        ));
  }
}
