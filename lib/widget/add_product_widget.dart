// aggiungi prodotto
// ignore_for_file: prefer_const_constructors, unnecessary_new, camel_case_types

import 'dart:core';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;

var nameController = new TextEditingController();
var numberController = new TextEditingController();
var dateController = new TextEditingController();

class addProductClass extends StatefulWidget {
  @override
  _addProductClassState createState() => _addProductClassState();
}

class _addProductClassState extends State<addProductClass> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    return Container(
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
          Text('${date.year}-${date.month}-${date.day}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          ElevatedButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                if (newDate == null) return;
                setState(() => date = newDate);
              },
              child: Text("Inserisci la data di scadenza")),
          ElevatedButton(
            child: Text('Aggiungi'),
            onPressed: () {
              insertData(nameController.text, numberController.text,
                  '${date.year}-${date.month}-${date.day}');
            },
          ),
        ]));
  }
}

void insertData(String name, String number, String expirationDate) {
  db
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .collection('dispensa')
      .doc(nameController.text)
      .set({
    'name': name,
    'number': number,
    'expirationDate': expirationDate,
  });
}
