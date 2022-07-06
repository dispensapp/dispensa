// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class HomePageWidget extends StatelessWidget {
  final FirebaseAuth firebase_auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Bentornato, Mario!',
          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: PALETTE_WHITE,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Dispensa",
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(fontSizeFactor: 1.5)),
                      SizedBox(height: 10),
                      Text(
                          "Il 56% dei prodotti in dispensa stanno per scadere"),
                      SizedBox(height: 15),
                      LinearProgressIndicator(
                          value: 0.7,
                          backgroundColor: Color.fromARGB(255, 255, 233, 188),
                          color: PALETTE_DARK_YELLOW)
                    ]))),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("SCADENZE",
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 1)),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //set shadow
                          decoration: BoxDecoration(
                              color: PALETTE_WHITE,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            Image.asset('assets/images/test.png', width: 50),
                            Text("Pan di stelle"),
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: PALETTE_LIGHT_YELLOW,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text("20 FEB"),
                            )
                          ]),
                        ),
                        Container(
                          //set shadow
                          decoration: BoxDecoration(
                              color: PALETTE_WHITE,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            Image.asset('assets/images/test.png', width: 50),
                            Text("Pan di stelle"),
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: PALETTE_LIGHT_YELLOW,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text("20 FEB"),
                            )
                          ]),
                        ),
                        Container(
                          //set shadow
                          decoration: BoxDecoration(
                              color: PALETTE_WHITE,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            Image.asset('assets/images/test.png', width: 50),
                            Text("Pan di stelle"),
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: PALETTE_LIGHT_YELLOW,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text("20 FEB"),
                            )
                          ]),
                        )
                      ])
                ])),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("RISPARMIA",
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 1)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Text("Esselunga"),
                              Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: PALETTE_LIGHT_YELLOW,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text("20 FEB"),
                              )
                            ],
                          ))
                    ],
                  )
                ]))
      ],
    );
  }
}
