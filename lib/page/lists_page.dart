// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, camel_case_types

import 'package:dispensa/utils/constants.dart';
import 'package:flutter/material.dart';
import '../widget/add_list.dart';

class ListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          //add color
          backgroundColor: PALETTE_BLUE,
          onPressed: () {
            //show addproductclass
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addListElementClass()),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Container(
            //set margin of 20
            margin: EdgeInsets.all(20),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Liste',
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 2.0),
                  ),

                  //create floating action button in bottom of screen
                ])));
  }
}
