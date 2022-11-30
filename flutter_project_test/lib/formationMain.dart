import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_project_test/CustomDialog.dart';
import 'package:flutter_project_test/Formation.dart';

//import 'package:flutter_project_test/otherDetails.dart';
import 'package:http/http.dart' as http;

//import 'CustomDialog.dart';

List<Formation> _formations = [];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormationPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class FormationPage extends StatefulWidget {
  const FormationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  FormationPageState createState() => FormationPageState();
}

class FormationPageState extends State<FormationPage> {
  int p = 0;

  ///final String url = 'http://192.168.1.19:8085/FORMATION-SERVER/formations';
 

  /// Set default number of rows to be displayed per page
  var _rowsPerPage = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child:  tableFormation() 

      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: "Formations",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Sessions",
            icon: Icon(Icons.grid_view),
          ),
          BottomNavigationBarItem(
            label: "Comptes",
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}

