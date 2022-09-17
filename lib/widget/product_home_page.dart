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

    return FutureBuilder<DocumentSnapshot>(
      future: productsData.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          DateTime expirDateConv = DateTime.parse(data['expirationDate']);
          //create a card in material ui 3
          return Container(
            margin: EdgeInsets.only(right: 30),
            //set content to start
            alignment: Alignment.centerLeft,
            //set padding
            child: Column(
              children: [
                Image.network(
                    "https://www.antoniopaolillo.com/wp-content/uploads/2020/03/mela-rossa-1-scaled.jpg",
                    width: 50),
                Text("${data['name']}",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.5)),
                //trasforma la data di scadenza in giorni
                //trasforma la stringa expirationDate in datetime

                Container(
                  //set padding and background color
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: PALETTE_WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                      "${expirDateConv.difference(DateTime.now()).inDays} giorni"),
                ),
                Text("${data['number']} pz")
              ],
            ),
          );
        }

        return Text("Caricamento");
      }),
    );
  }
}
