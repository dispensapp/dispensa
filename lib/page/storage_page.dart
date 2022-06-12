// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, camel_case_types, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../index.dart';
import '../utils/constants.dart';

class StoragePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Container content = Container(
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Dispensa',
              style:
                  DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
            ),
            Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: LIGHT_RED,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/test.png', width: 50),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Spaghetti",
                                  style: DefaultTextStyle.of(context)
                                      .style
                                      .apply(fontSizeFactor: 1.5)),
                              Text("Scadenza: 12/12/2020")
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [Text("1"), Text("pz")],
                        ))
                  ],
                )),
            Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: LIGHT_RED,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/test.png', width: 50),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Spaghetti",
                                  style: DefaultTextStyle.of(context)
                                      .style
                                      .apply(fontSizeFactor: 1.5)),
                              Text("Scadenza: 12/12/2020")
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [Text("1"), Text("pz")],
                        ))
                  ],
                ))
          ],
        ));
    return header(content, context);
  }
}
