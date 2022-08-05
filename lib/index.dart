// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, dead_code

import 'package:dispensa/page/buy_page.dart';
import 'package:dispensa/page/lists_page.dart';
import 'package:dispensa/page/home_page.dart';
import 'package:dispensa/page/storage_page.dart';
import 'package:dispensa/provider/google_sign_in.dart';
import 'package:dispensa/utils/constants.dart';
import 'package:dispensa/widget/add_product_widget.dart';
import 'package:dispensa/widget/sign_up_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  final screens = [HomePage(), StoragePage(), ListsPage(), BuyPage()];
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
                  label: 'Liste',
                ),
                NavigationDestination(
                  icon: Icon(Icons.money_outlined),
                  label: 'Risparmia',
                ),
              ],
            )),
      );
}

header(Container content, context) {
  DateTime date = DateTime.now();
  final user = FirebaseAuth.instance.currentUser;

  //final user = FirebaseAuth.instance.currentUser!;
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
                  margin: EdgeInsets.only(top: 20, left: 10),
                  child: Row(children: [
                    PopUpMenu(
                      menuList: const [
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(
                              CupertinoIcons.person,
                            ),
                            title: Text("My Profile"),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(
                              CupertinoIcons.bag,
                            ),
                            title: Text("My Bag"),
                          ),
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          child: Text("Settings"),
                        ),
                        PopupMenuItem(
                          child: Text("About Us"),
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(
                              Icons.logout,
                            ),
                            title: Text("Log Out"),
                            onTap: logout,
                          ),
                        ),
                      ],
                      icon: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(user!.photoURL!),
                      ),
                    )
                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10),
                    child: IconButton(
                      onPressed: () => showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          )),
                          context: context,
                          builder: (context) => addProduct(date, context)),
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

class PopUpMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMenu({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}
