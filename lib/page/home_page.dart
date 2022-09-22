// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, camel_case_types, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/page/storage_page.dart';
import 'package:dispensa/widget/dispensa_product_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../provider/google_sign_in.dart';
import '../utils/constants.dart';
import '../widget/add_product.dart';
import '../widget/lista_product_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final FirebaseAuth firebase_auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  List<String> dataStorageIDs = [];
  List<String> dataListeIDs = [];

  //get data from Firestore
  Future getStorageId() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection("dispensa")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              dataStorageIDs.add(document.reference.id);
            }));
  }

  Future getListeId() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection("liste")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              dataListeIDs.add(document.reference.id);
            }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          //add color
          backgroundColor: PALETTE_BLUE,
          onPressed: () {
            //show addproductclass
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addProductClass()),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                //set margin top
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          //set margin
                          radius: 15,
                          backgroundImage: NetworkImage(user!.photoURL!),
                        ),
                        //insert space between avatar and text
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bentornato,',
                              style: DefaultTextStyle.of(context).style.apply(
                                    fontSizeFactor: 0.8,
                                  ),
                            ),
                            Text(
                              user!.displayName.toString(),
                              style: DefaultTextStyle.of(context).style.apply(
                                  fontSizeFactor: 1.2,
                                  color: Color.fromARGB(255, 26, 26, 26)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.logout,
                          //set color
                          color: Colors.black,
                        ),
                        onPressed: logout),
                  ],
                ),
              ),
              //create header with start "welcome back" at start of screen and image of the user at the end

              Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: PALETTE_WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Dispensa",
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .apply(fontSizeFactor: 1.5)),
                            SizedBox(height: 10),
                            Text(
                                "Il 56% dei prodotti in dispensa stanno per scadere"),
                            SizedBox(height: 15),
                            LinearProgressIndicator(
                                value: 0.7,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 233, 188),
                                color: PALETTE_DARK_YELLOW)
                          ]))),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                            //insert between
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("DISPENSA",
                                  style: DefaultTextStyle.of(context)
                                      .style
                                      .apply(fontSizeFactor: 1)),
                              //button with icon to view dispensa page
                              IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    //set color
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    //change navigationdestination to storage page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoragePage()),
                                    );
                                  }),
                            ]),
                        SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 150,
                          ),
                          child: FutureBuilder(
                              future: getStorageId(),
                              builder: (context, snapshot) {
                                if (dataStorageIDs.isNotEmpty) {
                                  return ListView.builder(
                                    //insert card margin
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: dataStorageIDs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return productCard(
                                        documentId: dataStorageIDs[index],
                                      );
                                    },
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                        ),
                        SizedBox(height: 10),
                        Text("LISTE",
                            //onclick to go to list page

                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 1)),
                        SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 151,
                          ),
                          child: FutureBuilder(
                              future: getListeId(),
                              builder: (context, snapshot) {
                                if (dataListeIDs.isNotEmpty) {
                                  return ListView.builder(
                                    //insert card margin
                                    scrollDirection: Axis.vertical,
                                    itemCount: dataListeIDs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return listaCard(
                                        documentId: dataListeIDs[index],
                                      );
                                    },
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                        ),
                      ])),
            ],
          ),
        ));
  }
}
