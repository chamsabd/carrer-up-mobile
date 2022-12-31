import 'package:pflutter/pages/FormationList.dart';
import 'package:pflutter/pages/login.dart';
import 'package:pflutter/pages/verification.dart';

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
        '/': (context) => login(),
        '/stage': (context) => Stages(),
        '/formation': (context) => Formationlist(),
        '/add-stage': (context) => const AddEditStage(),
        '/verification': (context) => verification(),
      },
    );
  }
}
