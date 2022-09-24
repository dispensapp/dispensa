//create product details page that takes from database the product details
//and show them
//
// Compare this snippet from lib/widget/product_widget.dart:
// // ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
//
// ignore_for_file: prefer_const_constructors

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
  //create array with button names
  List<String> buttonNames = [
    "Descrizione",
    "Ingredienti",
    "Offerte",
    "Recensioni"
  ];
  int buttonClicked = 0;
  productDetails({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference productsData = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("dispensa");
    return Scaffold(
      //section of product details, with big image on top and product details
      //below
      body: FutureBuilder<DocumentSnapshot>(
        future: productsData.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            int tempNumber = data["number"];
            return Scaffold(
                //insert in bottom of screen the quantity of product, a button for encrease or decrease quantity. add also a save button
                bottomNavigationBar: Container(
                    margin: EdgeInsets.all(15),
                    height: 75,
                    child: Row(
                      //space between
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //buttons to decrease or encrease quantity of product
                        Container(
                          //insert border black
                          decoration: BoxDecoration(
                            color: Colors.white,
                            //rounded corners
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                            ),
                            //shadow
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 229, 229, 229)
                                    .withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 229, 229, 229)
                                          .withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    tempNumber++;
                                  },
                                  //set add icon
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Text(
                                tempNumber.toString(),
                                //center text
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 229, 229, 229)
                                          .withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    tempNumber++;
                                  },
                                  //set add icon
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ElevatedButton(
                          //palette blue color
                          style: ElevatedButton.styleFrom(
                            //color background yellow
                            primary: PALETTE_BLUE,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            //shadow
                            shadowColor: Color.fromARGB(255, 229, 229, 229)
                                .withOpacity(0.1),
                            elevation: 5,
                          ),
                          onPressed: () {
                            //save new quantity of product
                            productsData.doc(documentId).update({
                              "number": tempNumber,
                            });
                            Navigator.pop(context);
                          },

                          child: Text(
                            "Salva",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              //font normal
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )),
                body: Column(
                  //elements at start
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    //image of product
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          //if image is = "" (empty), show default image
                          image: NetworkImage(
                            data['image'] == ""
                                ? "https://www.yegam.it/wp-content/uploads/2019/05/yegam-blog-slow-food.jpg"
                                : data['image'],
                            //bottom rounded corners
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //product details
                    Container(
                      margin: EdgeInsets.all(40),
                      child: Column(
                          //elements at start
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //product name
                            Row(
                              //insert between
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['name'],
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    //letter spacing
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    color: PALETTE_LIGHT_YELLOW,
                                    borderRadius: BorderRadius.circular(5),
                                    //set shadow
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 229, 229, 229)
                                                .withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    //trasforma la data in numero di giorni che mancano alla scadenza
                                    data['expirationDate'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      //bold
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),

                            Text(
                              data['category'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            Container(
                              height: 50,
                              child: ListView.builder(
                                //scroll horizontal
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: ElevatedButton(

                                          //set rounded borders
                                          style: ElevatedButton.styleFrom(
                                            //on focus change color
                                            primary: buttonClicked == index
                                                ? PALETTE_BLUE
                                                : Colors.white,
                                            //text color
                                            onPrimary: buttonClicked == index
                                                ? Colors.white
                                                : Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            //set shadow
                                            shadowColor: Color.fromARGB(
                                                    255, 229, 229, 229)
                                                .withOpacity(0.1),
                                            elevation: 5,
                                          ),
                                          child: Text(buttonNames[index]),
                                          onPressed: () =>
                                              {buttonClicked = index}));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //insert a description
                            Text(
                              data['description'],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]),
                    ),
                  ],
                ));
          }
          return Text("loading");
        }),
      ),
    );
  }
}
