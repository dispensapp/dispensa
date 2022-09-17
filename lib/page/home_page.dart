// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, camel_case_types, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/widget/product_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import '../provider/google_sign_in.dart';
import '../utils/constants.dart';
import '../widget/add_product_widget.dart';
import '../widget/product_widget.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth firebase_auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  List<String> dataIDs = [];

  //get data from Firestore
  Future getDocId(type) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection(type)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              dataIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            backgroundColor: Color.fromARGB(255, 255, 233, 188),
                            color: PALETTE_DARK_YELLOW)
                      ]))),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("DISPENSA",
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 1)),
                    SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 150,
                      ),
                      child: FutureBuilder(
                          future: getDocId("dispensa"),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              //insert card margin
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: dataIDs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return productCard(
                                  documentId: dataIDs[index],
                                );
                              },
                            );
                          }),
                    ),
                    Text("LISTE",
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 1)),
                    SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 150,
                      ),
                      child: FutureBuilder(
                          future: getDocId("liste"),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              //insert card margin
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: dataIDs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return productCard(
                                  documentId: dataIDs[index],
                                );
                              },
                            );
                          }),
                    ),
                  ])),
        ],
      ),
    ));
  }
}
