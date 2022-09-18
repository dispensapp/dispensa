// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, camel_case_types, must_be_immutable, prefer_const_literals_to_create_immutables, unused_element, no_logic_in_create_state, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import '../widget/add_product.dart';
import '../widget/product_widget.dart';

class StoragePage extends StatefulWidget {
  @override
  State<StoragePage> createState() => _StoragePage();
}

class _StoragePage extends State<StoragePage> {
  List<String> dataIDs = [];

  //get data from Firestore
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection("dispensa")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              dataIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //add dispensa title

        //add button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addProductClass()),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Dispensa',
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 2.0),
                      ),

                      //create floating action button in bottom of screen
                    ]),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: FutureBuilder(
                    future: getDocId(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataIDs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GetProduct(
                            documentId: dataIDs[index],
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
