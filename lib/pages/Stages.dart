import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pflutter/pages/stageitem.dart';
import 'package:pflutter/services/auth_service.dart';

import 'package:pflutter/services/stage_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';
import '../modal/stage.dart';
import 'drawer.dart';

class Stages extends StatefulWidget {
  Stages({super.key});

  @override
  State<Stages> createState() => _StageState();
}

class _StageState extends State<Stages> {
  bool isApiCallProcess = false;
  var stageService = StageService();
  var authService = AuthService();
  var _isShown = false;
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();
  List<dynamic> stages = [];
  var role = "";
  @override
  void initState() {
    //  getStages();
    authService.roles().then((value) =>
        {this.role = value, debugPrint("role in init state" + role)});

    super.initState();
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
          icon: Icon(Icons.menu),
        ), // Set menu icon at leading of AppBar
      ),
      key: _drawerscaffoldkey,
      drawer: drawer(),
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadStages(),
      ),
    );
  }

  Widget loadStages() {
    debugPrint("role" + this.role);
    return FutureBuilder<List<Stage>>(
      future: stageService.getStages(),
      initialData: [],
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Stage>?> model,
      ) {
        debugPrint('data: ' + model.data.toString());
        if (model.hasData) {
          return list(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget list(stages) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              role == "ROLE_RH"
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(88, 36),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/add-stage',
                        );
                      },
                      child: const Text('Add stage'),
                    )
                  : Container(),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: stages.length,
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return stageitem(
                      stage: stages[index],
                      role: role,
                      onDelete: (Stage model) {
                        setState(() {
                          _isShown = true;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              title: const Text('Please Confirm'),
                              content:
                                  const Text('Are you sure to remove the box?'),
                              actions: [
                                // The "Yes" button
                                TextButton(
                                    onPressed: () {
                                      // Remove the box

                                      debugPrint("on delete : ");
                                      StageService.deleteStage(model.id).then(
                                        (response) {
                                          setState(() {
                                            isApiCallProcess = false;
                                          });
                                        },
                                      );
                                      setState(() {
                                        _isShown = false;
                                      });
                                      // Close the dialog
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      // Close the dialog
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text('No'))
                              ],
                            );
                          },
                        );
                      },
                    );
                  })
            ],
          )
        ],
      ),
    );
  }
}
