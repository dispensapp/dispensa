// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors

import 'package:dispensa/page/buy_page.dart';
import 'package:dispensa/page/calendar_page.dart';
import 'package:dispensa/page/home_page.dart';
import 'package:dispensa/page/storage_page.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  final screens = [HomePage(), StoragePage(), CalendarPage(), BuyPage()];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Colors.red.shade200,
              labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            child: NavigationBar(
              height: 80,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              backgroundColor: SECONDARY_RED,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              selectedIndex: index,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.house_siding_rounded),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.storage_outlined),
                  label: 'Dispensa',
                ),
                NavigationDestination(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: 'Scadenze',
                ),
                NavigationDestination(
                  icon: Icon(Icons.money_off_csred_outlined),
                  label: 'Risparmia',
                ),
              ],
            )),
      );
}
