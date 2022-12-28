import 'package:flutter/material.dart';
import 'package:flutterviz/HomeScreen.dart';
import 'package:flutterviz/signup.dart';

import 'FormationList.dart';
import 'addFormation.dart';
import 'formationMain.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarrerUP',
      home: FormationAddEdit(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
