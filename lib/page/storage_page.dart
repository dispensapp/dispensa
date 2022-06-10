import 'package:flutter/material.dart';
import '../utils/constants.dart';

class StoragePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.green),
              height: MediaQuery.of(context).size.height,
            )
          ],
        ),
      )),
    );
  }
}
