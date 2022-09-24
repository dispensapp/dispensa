// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:core';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/page/storage_page.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:dispensa/widget/storage/product_details.dart';
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
          //open product details page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => productDetails(documentId: documentId)),
          );
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
                  DateTime expirDateConv =
                      DateTime.parse(data['expirationDate']);

                  return Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.network(
                                data['image'] == ""
                                    ? "https://www.yegam.it/wp-content/uploads/2019/05/yegam-blog-slow-food.jpg"
                                    : data['image'],
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover),
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
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            //remove product from database and reload page
                            productsData.doc(documentId).delete();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoragePage()),
                            );
                          },
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
