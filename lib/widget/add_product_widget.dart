// aggiungi prodotto
// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final databaseRef = FirebaseDatabase.instance.ref();

var nameController = new TextEditingController();
var numberController = new TextEditingController();
var dateController = new TextEditingController();

Widget addProduct(date, context) => Container(
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
          controller: nameController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Numero del prodotto'
        ),
      )),
      Text('${date.year}/${date.month}/${date.day}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      ElevatedButton(
          onPressed: () async {
            showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2019, 1, 15),
                lastDate: DateTime(2030, 1, 15));
          },
          child: Text('Inserisci la data di scadenza')),
      ElevatedButton(
        child: Text('Aggiungi'),
        onPressed: () {insertData()},
      ),
    ]));

void insertData(String name, Int number, DateTime expirationDate) {
  databaseRef.child("path").set({
    "name": name,
    "number": number,
    "expirationDate": expirationDate.toString()
  });
}
