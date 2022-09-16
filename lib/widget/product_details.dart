//create product details page that takes from database the product details
//and show them
//
// Compare this snippet from lib/widget/product_widget.dart:
// // ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
//
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//create product details page that takes from database the product details
//and show them
class productDetails extends StatelessWidget {
  final String documentId;
  final user = FirebaseAuth.instance.currentUser;

  productDetails({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference productsData = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("dispensa");
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: PALETTE_LIGHT_YELLOW,
            ),
          )
        ],
      ),
    );
  }
}
