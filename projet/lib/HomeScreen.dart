///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:flutterviz/drawer.dart';
import 'package:flutterviz/signup.dart';

import 'categories.dart';
import 'formationMain.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff3a57e8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "CarrerUp",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            //on drawer menu pressed
            if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
              //if drawer is open, then close the drawer
              Navigator.pop(context);
            } else {
              _drawerscaffoldkey.currentState!.openDrawer();
              //if drawer is closed then open the drawer.
            }
          },
          icon: Icon(Icons.menu),
        ), // Set menu icon at leading of AppBar
      ),
      key: _drawerscaffoldkey,
      body: SafeArea(child: signup()),
      drawer: drawer(),
    );
  }
}
