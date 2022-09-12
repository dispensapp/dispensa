// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, camel_case_types

import 'package:flutter/material.dart';
import '../index.dart';
import '../utils/constants.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class ListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Container content = Container(
        margin: EdgeInsets.all(30),
        child: Column(
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

              FloatingActionButton.extended(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),

              //add bottom button
            ]));
    return header(content, context);
  }
}
