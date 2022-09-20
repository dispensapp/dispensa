// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:dispensa/widget/add_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class listaCard extends StatelessWidget {
  final String documentId;
  final user = FirebaseAuth.instance.currentUser;

  listaCard({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference productsData = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("liste");

    return FutureBuilder<DocumentSnapshot>(
      future: productsData.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          try {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
          } catch (e) {
            return GestureDetector(
                onTap: () {
                  //open create list class

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => addListElementClass()),
                  );
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: LIGHT_GRAY,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    //text nessun element nella lista
                    child: Row(
                      //center content
                      children: [
                        //add icon
                        Icon(
                          Icons.add_box,
                          color: PALETTE_BLUE,
                          size: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          //align content to left
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: const [
                            Text("Nessuna lista disponibile",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text("Clicca qui per aggiungerne una!")
                          ],
                        ),
                      ],
                    )));
          }
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
                children: [],
              ));
        }

        return Text("");
      }),
    );
  }
}
