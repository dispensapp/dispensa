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
                        Text('Rochambeau!',
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 2.0)),
                      ],
                    )))
          ],
        ),
      )),
    ));
  }
}
