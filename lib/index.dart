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
              backgroundColor: BOTTOM_RED,
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

header(Container content, context) {
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
                        icon: const Icon(Icons.supervised_user_circle_outlined,
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
              child: content)
        ],
      ),
    )),
  ));
}
