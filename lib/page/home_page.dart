// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, camel_case_types, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/page/lists_page.dart';
import 'package:dispensa/page/storage_page.dart';
import 'package:dispensa/widget/home/dispensa_product_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../provider/google_sign_in.dart';
import '../utils/constants.dart';
import '../widget/storage/add_product.dart';
import '../widget/home/lista_product_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  //scraping sales from e-coop.it

  final List<String> images = [
    //"https://www.e-coop.it/sites/default/files/2022-06/TRIPLA_CONVENIENZA_DesktopHP-1103x488-01.png",
    "https://www.sconticondivisi.it/wp-content/uploads/2022/08/fai-la-spesa-col-cuore-unes-spendi-10e-ricevi-10e-dove-e-come-partecipare.jpg",
    "https://www.sbirciaprezzo.com/wp-content/uploads/2017/09/Esselunga-Speciale-multimediale-ed-elettrodomestici-dal-7-al-20-Settembre-2017.jpg",
    "https://coopmarostica.it/wp-content/uploads/2022/09/Coop-piano-editoriale-09-08.jpg"
  ];

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

              Column(children: [
                SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                  items: images
                      .map((item) => Container(
                            child: Center(
                                child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: 1000,
                            )),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 140,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ]),
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
                        Row(
                            //insert between
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("LISTE",
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
                                          builder: (context) => ListsPage()),
                                    );
                                  }),
                            ]),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 130,
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
