// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, dead_code

import 'package:dispensa/page/buy_page.dart';
import 'package:dispensa/page/calendar_page.dart';
import 'package:dispensa/page/home_page.dart';
import 'package:dispensa/page/storage_page.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:dispensa/widget/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //int index = 0;
  //final screens = [HomePage(), StoragePage(), CalendarPage(), BuyPage()];
  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.all(30),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            return HomePageWidget();
          } else {
            return Center(child: Text('Unknown error'));
          }
        },
      ));
}

header(Container content, context) {
  DateTime date = DateTime.now();
  //final user = FirebaseAuth.instance.currentUser!;
  return Scaffold(
      body: Container(
    color: PALETTE_BLUE,
    child: SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 5, 62, 92),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: EdgeInsets.only(top: 20, left: 10),
                  padding: EdgeInsets.all(1),
                  child: Row(children: [
                    /*CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),*/
                    IconButton(
                        // set a margin top
                        onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (context) => addProduct(),
                            ),
                        icon: const Icon(Icons.menu,
                            size: 20, color: Colors.white)),
                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10),
                    child: IconButton(
                      onPressed: scanBarCode,
                      icon: const Icon(Icons.add, color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Color.fromARGB(255, 255, 254, 247)),
              height: MediaQuery.of(context).size.height,
              child: content)
        ],
      ),
    )),
  ));
}

// aggiungi prodotto
addProduct() {
  Container(
      margin: EdgeInsets.all(40),
      child: Column(children: [
        Text('Aggiungi un prodotto',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nome del prodotto',
            ),
          ),
        ),

        /*Text('${date.year}/${date.month}/${date.day}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ElevatedButton(
            onPressed: () async {
              showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2019, 1, 15),
                  lastDate: DateTime(2030, 1, 15));
            },
            child: Text('Inserisci la data di scadenza')),*/
      ]));
}

Future scanBarCode() async {
  String scanResult;
  try {
    scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.BARCODE);
  } on PlatformException {
    scanResult = 'Failed to get platform version.';
  }

  //if (!mounted) return;
}
