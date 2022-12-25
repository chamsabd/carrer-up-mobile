import 'dart:convert';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterviz/Session.dart';

//import 'package:flutter_project_test/otherDetails.dart';
import 'package:http/http.dart' as http;

import 'Formation.dart';
import 'FormationList.dart';
import 'categories.dart';
import 'drawer.dart';

//import 'CustomDialog.dart';

List<Formation> _formations = [];

class FormationPage extends StatefulWidget {
  @override
  FormationPageState createState() => FormationPageState();
}

class FormationPageState extends State<FormationPage> {
  final String url = 'http://192.168.1.12:8085/FORMATION-SERVER/formations/';

  bool loading = true;
  late Future<List<Formation>> futurePersons;
  @override
  void initState() {
    super.initState();
    futurePersons = fetchFormations();
  }

  Future<List<Formation>> fetchFormations() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("ttttttttttttt");
      //log(jsonDecode(response.body)["content"].toString());
      final parsed = jsonDecode(response.body)["content"] as List;
      log(parsed.toString());
      log("hjhjhjhjjjhj");

      _formations =
          parsed.map<Formation>((json) => Formation.fromJson(json)).toList();
      log(_formations.toString());
      return _formations;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _drawerscaffoldkey =
        new GlobalKey<ScaffoldState>();
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
        drawer: drawer(),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                    child: Text(
                      "All Trainig Courses by CarrerUP",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        color: Color(0xff272727),
                      ),
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: _formations.length,
                    itemBuilder: (context, position) {
                      return Card(
                        child: InkWell(
                            child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: FormationList(f: _formations[position]),
                        )),
                      );
                    },
                  )
                ]))));
  }
}
