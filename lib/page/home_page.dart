// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import '../utils/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: PRIMARY_RED,
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
                        color: SECONDARY_RED,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.only(top: 20, left: 10),
                    padding: EdgeInsets.all(1),
                    child: Row(children: [
                      IconButton(
                          // set a margin top
                          onPressed: () {},
                          icon: const Icon(
                              Icons.supervised_user_circle_outlined,
                              size: 25)),
                      IconButton(
                          // set a margin top
                          onPressed: () {},
                          icon: const Icon(Icons.menu, size: 20)),
                    ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, right: 10),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
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
                    color: Colors.white),
                height: MediaQuery.of(context).size.height,
                child: Container(
                    margin: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Bentornato Mario!',
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(fontSizeFactor: 2.0),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                color: LIGHT_RED,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text("Dispensa",
                                          style: DefaultTextStyle.of(context)
                                              .style
                                              .apply(fontSizeFactor: 1.5)),
                                      SizedBox(height: 10),
                                      Text(
                                          "Il 56% dei prodotti in dispensa sta per scadere"),
                                      SizedBox(height: 15),
                                      LinearProgressIndicator(
                                          value: 0.7,
                                          backgroundColor: SECONDARY_LIGHT_RED,
                                          color: PROGRESS_RED)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          //set shadow
                                          decoration: BoxDecoration(
                                              color: LIGHT_RED,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          padding: EdgeInsets.all(15),
                                          child: Column(children: [
                                            Image.asset(
                                                'assets/images/test.png',
                                                width: 50),
                                            Text("Pan di stelle"),
                                            Container(
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                  color: PRIMARY_RED,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              child: Text("20 FEB"),
                                            )
                                          ]),
                                        ),
                                        Container(
                                          //set shadow
                                          decoration: BoxDecoration(
                                              color: LIGHT_RED,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          padding: EdgeInsets.all(15),
                                          child: Column(children: [
                                            Image.asset(
                                                'assets/images/test.png',
                                                width: 50),
                                            Text("Pan di stelle"),
                                            Container(
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                  color: PRIMARY_RED,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              child: Text("20 FEB"),
                                            )
                                          ]),
                                        ),
                                        Container(
                                          //set shadow
                                          decoration: BoxDecoration(
                                              color: LIGHT_RED,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          padding: EdgeInsets.all(15),
                                          child: Column(children: [
                                            Image.asset(
                                                'assets/images/test.png',
                                                width: 50),
                                            Text("Pan di stelle"),
                                            Container(
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                  color: PRIMARY_RED,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            children: [
                                              Text("Esselunga"),
                                              Container(
                                                padding: EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                    color: PRIMARY_RED,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: Text("20 FEB"),
                                              )
                                            ],
                                          ))
                                    ],
                                  )
                                ]))
                      ],
                    )))
          ],
        ),
      )),
    ));
  }
}
