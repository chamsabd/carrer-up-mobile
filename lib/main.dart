
import 'package:pflutter/pages/login.dart';
import 'package:pflutter/pages/verification.dart';

import 'pages/formationMain.dart';
import 'package:pflutter/pages/Stages.dart';
import 'package:pflutter/pages/addeditStage.dart';

import 'package:flutter/material.dart';

import 'pages/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => signup(),
        '/stage': (context) => Stages(),
        '/formation': (context) => FormationPage(),
        '/add-stage': (context) => const AddEditStage(),
       '/verification': (context) =>  verification(),
       '/login': (context) =>  login(),
      },

    );
  }
}


