// aggiungi prodotto
// ignore_for_file: prefer_const_constructors, unnecessary_new, camel_case_types
import 'package:dispensa/index.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';

import 'package:openfoodfacts/model/OcrIngredientsResult.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/TagType.dart';

final db = FirebaseFirestore.instance;

var nameController = new TextEditingController();
var numberController = new TextEditingController();
var dateController = new TextEditingController();
var imageController = new TextEditingController();

class addProductClass extends StatefulWidget {
  @override
  _addProductClassState createState() => _addProductClassState();
}

DateTime date = DateTime.now();

class _addProductClassState extends State<addProductClass> {
  String? scanResult;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  // insert gap

                  Text('Aggiungi un prodotto',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
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
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
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
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        showCursor: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.date_range_rounded),
                          labelText: 'Data di scadenza',
                          hintText: dateController.text,
                          border: OutlineInputBorder(),
                        ),
                        //check if there is content
                        validator: (value) => value!.isEmpty
                            ? 'Inserisci una data'
                            : int.tryParse(value) == null
                                ? 'Inserisci una data'
                                : null,
                        controller: dateController,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          if (newDate == null) return;
                          setState(() => dateController.text =
                              '${newDate.year}-${newDate.month}-${newDate.day}');
                        },
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PALETTE_BLUE,
                        minimumSize: Size.fromHeight(50), // NEW
                      ),
                      //on pressed async

                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          try {
                            insertData(
                                nameController.text,
                                int.parse(numberController.text),
                                '${date.year}-${date.month}-${date.day}');
                            Navigator.pop(context);
                            _formKey.currentState?.reset();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Errore nel salvataggio dei dati:$e"),
                            ));
                          }
                        }
                      },
                      child: Text('Aggiungi'),
                    ),
                  )
                ])))
      ],
    );
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
      } else {
        throw Exception(
            'product not found, please insert data for $scanResult');
      }
      return null;
    } on PlatformException {
      scanResult = 'Non è stato possibile trovare il prodotto.';
    }

    //if (!mounted) return;
  }
}

void insertData(String name, int number, String expirationDate) {
  db
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .collection('dispensa')
      .doc(nameController.text)
      .set({
    'name': name,
    'number': number,
    'expirationDate': expirationDate,
    'image': imageController.text
  });
}
