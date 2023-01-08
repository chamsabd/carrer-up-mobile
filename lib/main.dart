import 'dart:html';

import 'package:pflutter/pages/FormationList.dart';
import 'package:pflutter/pages/Users.dart';
import 'package:pflutter/pages/accessdenied.dart';
import 'package:pflutter/pages/login.dart';
import 'package:pflutter/pages/verification.dart';

import 'package:pflutter/pages/Stages.dart';
import 'package:pflutter/pages/addeditStage.dart';

import 'package:flutter/material.dart';
import 'package:pflutter/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  late var role;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => check(login()),
        '/login': (context) => check(login()),
        '/stage': (context) => check(Stages()),
        '/signup': (context) => check(signup()),
        '/formation': (context) => Formationlist(),
        '/add-stage': (context) => check(AddEditStage()),
        '/users': (context) => check(Users()),
        '/verification': (context) => check(verification()),
        '/accessdenied': (context) => access(),
      },
    );
  }

  check(Widget route) {
    return FutureBuilder<Map<String, dynamic>>(
      // This is my async call to sharedPrefs
      future: AuthService.validate(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.data?['logedin']) {
              var role = snapshot.data?['role'];
              this.role = role;

              if (role != "ROLE_RH") {
                if (route.toString() == 'AddEditStage') {
                  return access();
                }
              }
              if (route.toString() == login().toString()) {
                return Formationlist();
              }

              return route;
            } else {
              if (route.toString() == login().toString() ||
                  route.toString() == signup().toString() ||
                  route.toString() == verification().toString()) {
                return route;
              }

              return login();
            }

          default:
            // I return an empty Container as long as the Future is not resolved
            return Container();
        }
        // if (snapshot.hasData) {
        //   debugPrint(snapshot.data?['logedin'].toString());
        //   // When the future is done I show either the LoginScreen
        //   // or the requested Screen depending on AuthState

        //   return route;

        //   // // I return an empty Container as long as the Future is not resolved
        //   // return Container();
        // } else {
        //   return login();
        // }
      },
    );
  }
}
