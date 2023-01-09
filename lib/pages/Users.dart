import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:pflutter/pages/usersitem.dart';
import 'package:pflutter/services/auth_service.dart';

import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../modal/User.dart';

import 'drawer.dart';

class Users extends StatefulWidget {
  Users({super.key});

  @override
  State<Users> createState() => _UserState();
}

class _UserState extends State<Users> {
  bool isApiCallProcess = false;
  var authService = AuthService();

  var _isShown = false;
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();
  List<dynamic> users = [];
  var role = "";
  @override
  void initState() {
    //  getUsers();
    authService.roles().then((value) =>
        {this.role = value, debugPrint("role in init state" + role)});

    super.initState();
    AuthService.getall().then((value) => null);
  }

  static var client = http.Client();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebebeb),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Listing",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xff000000),
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
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ), // Set menu icon at leading of AppBar
      ),
      key: _drawerscaffoldkey,
      drawer: drawer(),
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadUsers(),
      ),
    );
  }

  Widget loadUsers() {
    return FutureBuilder<List<User>>(
      future: AuthService.getall(),
      initialData: [],
      builder: (
        BuildContext context,
        AsyncSnapshot<List<User>?> model,
      ) {
        debugPrint('data: in users  ' + model.data.toString());
        if (model.hasData) {
          return list(model.data);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget list(users) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: users.length,
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return usersitem(
                      user: users[index],
                      role: role,
                    );
                  })
            ],
          )
        ],
      ),
    );
  }
}
