// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, dead_code
import 'package:dispensa/page/lists_page.dart';
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
  final screens = [HomePage(), StoragePage(), ListsPage()];
  @override
  Widget build(BuildContext context) => Scaffold(
        //white background
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: PALETTE_LIGHT_YELLOW,
              labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            child: NavigationBar(
              height: 80,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              backgroundColor: PALETTE_WHITE,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              selectedIndex: index,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.food_bank),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.fastfood),
                  label: 'Dispensa',
                ),
                NavigationDestination(
                  icon: Icon(Icons.list),
                  label: 'Liste',
                ),
              ],
            )),
      );
}
