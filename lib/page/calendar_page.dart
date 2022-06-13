// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, camel_case_types

import 'package:flutter/material.dart';
import '../index.dart';
import '../utils/constants.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Container content = Container(
        margin: EdgeInsets.all(30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Calendario',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
              SizedBox(height: 15),
              CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime(2019, 1, 15),
                lastDate: DateTime(2030, 11, 20),
                onDateSelected: (date) => print(date),
                leftMargin: 0,
                monthColor: Colors.black,
                dayColor: Colors.grey[800],
                activeDayColor: Colors.black,
                activeBackgroundDayColor: PALETTE_LIGHT_YELLOW,
                dotsColor: Color(0xFF333A47),
                //selectableDayPredicate: (date) => date.day != 23,
                locale: 'en_ISO',
              ),
              SizedBox(height: 10),
            ]));
    return header(content, context);
  }
}
