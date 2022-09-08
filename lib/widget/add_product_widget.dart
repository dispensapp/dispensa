// aggiungi prodotto
// ignore_for_file: prefer_const_constructors, unnecessary_new, camel_case_types
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = FirebaseFirestore.instance;

var nameController = new TextEditingController();
var numberController = new TextEditingController();
var dateController = new TextEditingController();

class addProductClass extends StatefulWidget {
  @override
  _addProductClassState createState() => _addProductClassState();
}

DateTime date = DateTime.now();

class _addProductClassState extends State<addProductClass> {
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
                  SizedBox(
                    height: 20,
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
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.date_range_rounded),
                          labelText: 'Data di scadenza',
                          prefixText: '${date.year}-${date.month}-${date.day}',
                          border: OutlineInputBorder(),
                        ),
                        //check if there is content
                        validator: (value) => value!.isEmpty
                            ? 'Inserisci una data'
                            : int.tryParse(value) == null
                                ? 'Inserisci una data'
                                : null,
                        controller: numberController,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          if (newDate == null) return;
                          setState(() => date = newDate);
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
  });
}
