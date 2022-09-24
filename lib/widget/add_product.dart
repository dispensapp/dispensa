// ignore_for_file: prefer_const_constructors, unnecessary_new, camel_case_types

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final db = FirebaseFirestore.instance;

var nameController = new TextEditingController();
var numberController = new TextEditingController();
var dateController = new TextEditingController();
var imageController = new TextEditingController();
var categoryController = new TextEditingController();

class addProductClass extends StatefulWidget {
  @override
  _addProductClassState createState() => _addProductClassState();
}

DateTime date = DateTime.now();

// something like 2013-04-20

class _addProductClassState extends State<addProductClass> {
  String? scanResult;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 15),
              child: Text("Aggiungi prodotto",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ))),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: PALETTE_LIGHT_YELLOW,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            icon: Icon(Icons.camera_alt_outlined),
            label: Text('Scannerizza'),
            onPressed: scanBarCode,
          ),
          SizedBox(
            height: 20,
          ),
          Form(
              key: _formKey,
              child: Column(children: [
                // intert image field

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Inserisci il nome del prodotto';
                    }
                    return null;
                  },
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.food_bank_rounded),
                    labelText: 'Nome del prodotto',
                    hintText: nameController.text,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller: categoryController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.category),
                    labelText: 'Categoria',
                    hintText: categoryController.text,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.format_list_numbered_outlined),
                    labelText: 'Quantità del prodotto',
                    border: OutlineInputBorder(),
                  ),
                  //check if there is content in the field and if the content is a number
                  validator: (value) => value!.isEmpty
                      ? 'Inserisci un numero'
                      : int.tryParse(value) == null
                          ? 'Inserisci un numero'
                          : null,
                  controller: numberController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  showCursor: true,
                  //hide keyboard
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.date_range_rounded),
                    labelText: 'Data di scadenza',
                    hintText: dateController.text,
                    border: OutlineInputBorder(),
                  ),
                  controller: dateController,
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    if (newDate == null) return;

                    //trasform date into yyyymmdd
                    setState(() {
                      date = newDate;
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(newDate);

                      dateController.text = formattedDate;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PALETTE_BLUE,
                      minimumSize: Size.fromHeight(50), // NEW
                    ),
                    //on pressed async

                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          insertData(
                              nameController.text,
                              int.parse(numberController.text),
                              dateController.text,
                              categoryController.text);
                          Navigator.pop(context);
                          _formKey.currentState?.reset();
                          //update app

                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Errore nel salvataggio dei dati:$e"),
                          ));
                        }
                      }
                    },
                    child: Text('Aggiungi',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                )
              ]))
        ],
      ),
    ));
  }

  Future scanBarCode() async {
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);

      print(scanResult);

      ProductQueryConfiguration configuration = ProductQueryConfiguration(
          scanResult!,
          language: OpenFoodFactsLanguage.ITALIAN,
          fields: [ProductField.ALL]);
      ProductResult result = await OpenFoodAPIClient.getProduct(configuration);

      if (result.status == 1) {
        print(result.product);
        nameController.text = result.product?.productName! as String;
        imageController.text = result.product?.imageFrontUrl as String;
        categoryController.text = result.product?.categories as String;
      } else {
        throw Exception('Prodotto non trovato, inserisci i dati manualmente');
      }
      return null;
    } on PlatformException {
      scanResult = 'Prodotto non trovato, inserisci i dati manualmente';
    }

    //if (!mounted) return;
  }
}

void insertData(
    String name, int number, String expirationDate, String category) {
  if (imageController.text == "") {
    imageController.text =
        "https://www.yegam.it/wp-content/uploads/2019/05/yegam-blog-slow-food.jpg";
  }
  db
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .collection('dispensa')
      .doc(nameController.text)
      .set({
    'name': name,
    'number': number,
    'expirationDate': expirationDate,
    'image': imageController.text,
    'category': category,
  });
}
