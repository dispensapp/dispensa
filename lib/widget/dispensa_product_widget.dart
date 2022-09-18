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
              //insert min width
              width: 150,
              //rounded corners
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: PALETTE_WHITE,
                //min width
                //min height
                //set margin
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

              //add backgorund color
              margin: EdgeInsets.only(right: 30),
              //set content to start
              alignment: Alignment.centerLeft,
              //set padding
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      data['image'],
                      width: 150,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data['name']}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),

                        //add sizedbox
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: PALETTE_LIGHT_YELLOW,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                    "${expirDateConv.difference(DateTime.now()).inDays} giorni",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ))),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                padding: EdgeInsets.all(5),
                                child: Text("${data['number']} pz",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  )

                  //trasforma la data di scadenza in giorni
                  //trasforma la stringa expirationDate in datetime
                ],
              ));
        }

        return Text("Caricamento");
      }),
    );
  }
}
