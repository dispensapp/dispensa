// aggiungi prodotto
// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:core';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../provider/user_setup.dart' as userSetup;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;

var nameController = new TextEditingController();
var numberController = new TextEditingController();
var dateController = new TextEditingController();

Widget addProduct(date, context) => Container(
    padding: EdgeInsets.all(20),
    child: Column(children: [
      Text('Aggiungi un prodotto',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Nome del prodotto',
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: numberController,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Numero del prodotto'),
          )),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: dateController,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Data di scadenza'),
          )),
      ElevatedButton(
        child: Text('Aggiungi'),
        onPressed: () {
          insertData(
              nameController.text, numberController.text, dateController.text);
        },
      ),
    ]));

void insertData(String name, String number, String expirationDate) {
  db
      .collection('Users')
      .doc("vIYDRU2iqgk6RQtVCUr9")
      .collection('Dispensa')
      .doc(nameController.text)
      .set({
    'name': name,
    'number': number,
    'expirationDate': expirationDate,
  });
}
