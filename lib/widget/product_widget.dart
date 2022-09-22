// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:core';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_icons/food_icons.dart';

class GetProduct extends StatelessWidget {
  final String documentId;
  final user = FirebaseAuth.instance.currentUser;

  GetProduct({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference productsData = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("dispensa");
    bool isButtonClicked = false;

    return InkWell(
        onTap: () {
          //set switch
          isButtonClicked = !isButtonClicked;
        },
        child: Container(
            //add gap on top and bottom
            margin: EdgeInsets.only(top: 10, bottom: 10),
            //rounded container
            decoration: BoxDecoration(
              //if button is clicked, color is yellow
              color:
                  isButtonClicked ? PALETTE_LIGHT_YELLOW : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(10),
            child: FutureBuilder<DocumentSnapshot>(
              future: productsData.doc(documentId).get(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  DateTime expirDateConv =
                      DateTime.parse(data['expirationDate']);

                  return Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FoodIcons.oven,
                              color: PALETTE_BLUE,
                              size: 40,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${data['name']}",
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .apply(fontSizeFactor: 1.5)),
                                  Row(
                                    children: [
                                      Text(
                                        "${data['number']} pz ",
                                        //bold
                                      ),
                                      SizedBox(width: 5),
                                      Text("•"),
                                      SizedBox(width: 5),
                                      Text((() {
                                        if (expirDateConv
                                            .isBefore(DateTime.now())) {
                                          return "Scaduto";
                                        } else {
                                          return "${expirDateConv.day}/${expirDateConv.month}/${expirDateConv.year}";
                                        }
                                      })(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        //remove button
                        IconButton(
                          icon: Icon(Icons.open_in_full),
                          onPressed: () {},
                        )
                      ],
                    ),
                    //when i click container, it creates a container that contains three buttons
                    //one for edit, one for delete and one for add
                    !isButtonClicked
                        ? Container(
                            //border black only on top
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.black, width: 1))),
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //edit button with icon and text below, margin between two elements = 0
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {},
                                    ),
                                    Text("Modifica")
                                  ],
                                ),

                                //add button with icon and text below, margin between two elements = 0
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                    Text("Aggiungi")
                                  ],
                                ),

                                //delete button with icon and text below material you
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        try {
                                          productsData.doc(documentId).delete();
                                        } catch (e) {
                                          //print error on app
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Errore nell'eliminazione: $e"),
                                          ));
                                        }
                                      },
                                    ),
                                    Text("Elimina")
                                  ],
                                ),
                              ],
                            ))
                        : Container()
                  ]);
                }
                return Text("Loading");
              }),
            )));
  }
}
