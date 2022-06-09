import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: PRIMARY_RED,
        border: Border.all(color: Colors.transparent, width: 2),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0)),
      ),
      child: Row(),
    );
  }
}
