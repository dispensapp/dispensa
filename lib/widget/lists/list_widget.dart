// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:core';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/page/lists_page.dart';
import 'package:dispensa/page/storage_page.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:dispensa/widget/lists/lists_details.dart';
import 'package:dispensa/widget/storage/product_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_icons/food_icons.dart';

class ListProduct extends StatelessWidget {
  final String documentId;
  final user = FirebaseAuth.instance.currentUser;

  ListProduct({required this.documentId});

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

    bool clicked = false;
    CollectionReference productsData = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("liste");

    return InkWell(
        onTap: () {
          //open product details page
          clicked = true;
        },
        child: Container(
            //add gap on top and bottom
            margin: EdgeInsets.only(top: 10, bottom: 10),
            //rounded container
            decoration: BoxDecoration(
              //if button is clicked, color is yellow
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              //set shadow
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 229, 229, 229).withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
            child: FutureBuilder<DocumentSnapshot>(
              future: productsData.doc(documentId).get(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Color.fromARGB(255, 255, 153, 0),
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
                                  Text(
                                    "${data['description']}",
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .apply(fontSizeFactor: 1),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        //remove button
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            //remove product from database and reload page
                            productsData.doc(documentId).delete();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListsPage()),
                            );
                          },
                        ),
                        //if clicked is equal to true, show products into container
                        if (clicked)
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child:
                                //create a listview of listElementsID
                                ListView.builder(
                              itemCount: listElementsID.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Text(listElementsID[index]),
                                );
                              },
                            ),
                          )
                      ],
                    ),
                    //when i click container, it creates a container that contains three buttons
                    //one for edit, one for delete and one for add
                  ]);
                }
                return Text("Loading");
              }),
            )));
  }
}
