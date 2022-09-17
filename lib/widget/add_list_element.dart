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
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:openfoodfacts/model/OcrIngredientsResult.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/TagType.dart';

final db = FirebaseFirestore.instance;

var nameController = new TextEditingController();
var numberController = new TextEditingController();
var dateController = new TextEditingController();
var imageController = new TextEditingController();

class addListElementClass extends StatefulWidget {
  @override
  _addListElementClassState createState() => _addListElementClassState();
}

DateTime date = DateTime.now();

class _addListElementClassState extends State<addListElementClass> {
  String? scanResult;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  // insert gap
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci il nome della lista';
                        }
                        return null;
                      },
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.list),
                        labelText: 'Nome della lista',
                        hintText: nameController.text,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        showCursor: true,
                        //hide keyboard
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.color_lens),
                          labelText: 'Colore',
                          hintText: dateController.text,
                          border: OutlineInputBorder(),
                        ),
                        controller: dateController,
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
                                dateController.text);
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
                      child: Text('Aggiungi',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ])))
      ],
    );
  }

  void insertData(String name, int number, String expirationDate) {
    db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection('liste')
        .doc(nameController.text)
        .set({
      'name': name,
      'color': number,
    });
  }
}
