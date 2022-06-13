// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, dead_code

import 'package:dispensa/page/buy_page.dart';
import 'package:dispensa/page/calendar_page.dart';
import 'package:dispensa/page/home_page.dart';
import 'package:dispensa/page/storage_page.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
                  icon: Icon(Icons.storage),
                  label: 'Dispensa',
                ),
                NavigationDestination(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: 'Scadenze',
                ),
                NavigationDestination(
                  icon: Icon(Icons.money_outlined),
                  label: 'Risparmia',
                ),
              ],
            )),
      );
}

buildSheet(date, context) {
  Container(
      margin: EdgeInsets.all(40),
      child: Column(children: [
        Text('Aggiungi un prodotto',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nome del prodotto',
            ),
          ),
        ),
        Text('${date.year}/${date.month}/${date.day}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ElevatedButton(
            onPressed: () async {
              showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2019, 1, 15),
                  lastDate: DateTime(2030, 1, 15));
            },
            child: Text('Inserisci la data di scadenza')),
      ]));
}

header(Container content, context) {
  DateTime date = DateTime.now();

  return Scaffold(
      body: Container(
    color: PALETTE_BLUE,
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
                      color: Color.fromARGB(255, 5, 62, 92),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: EdgeInsets.only(top: 20, left: 10),
                  padding: EdgeInsets.all(1),
                  child: Row(children: [
                    IconButton(
                        // set a margin top
                        onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (context) => buildSheet(date, context),
                            ),
                        icon: const Icon(Icons.supervised_user_circle_outlined,
                            size: 25, color: Colors.white)),
                    IconButton(
                        // set a margin top
                        onPressed: () {},
                        icon: const Icon(Icons.menu,
                            size: 20, color: Colors.white)),
                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10),
                    child: IconButton(
                      onPressed: scanBarCode,
                      icon: const Icon(Icons.add, color: Colors.white),
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
                  color: Color.fromARGB(255, 255, 254, 247)),
              height: MediaQuery.of(context).size.height,
              child: content)
        ],
      ),
    )),
  ));
}

Future scanBarCode() async {
  String scanResult;
  try {
    scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.BARCODE);
  } on PlatformException {
    scanResult = 'Failed to get platform version.';
  }
  //if (!mounted) return;
}
