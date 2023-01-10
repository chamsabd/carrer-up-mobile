///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:pflutter/services/auth_service.dart';
import './signup.dart';

import 'categories.dart';
import 'getDemandeList.dart';
import 'getInscritList.dart';

class drawer extends StatefulWidget {
  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  var role = "";
  @override
  void initState() {
    //  getStages();
    AuthService.rolee.then((value) => {
          this.role = value,
          debugPrint(
              "role in init state" + (role.toString() == 'ROLE_RH').toString())
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: AuthService.rolee,
      initialData: "",
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> model,
      ) {
        debugPrint('data: ' + model.data.toString());
        if (model.hasData) {
          return Drawer(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.all(0),
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xff3a57e8),
                  ),
                  child: Text('Never Stop Learning ...',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                (role.toString() == 'ROLE_RESPONSABLE') == true
                    ? ListTile(
                        leading: Icon(
                          Icons.book,
                        ),
                        title: const Text('Your Trainig Courses'),
                        onTap: () {
                          Navigator.pushNamed(context, "/formation");
                        },
                      )
                    : ListTile(),
                (role.toString() == 'ROLE_RESPONSABLE') == true
                    ? ListTile(
                        leading: Icon(
                          Icons.hourglass_bottom,
                        ),
                        title: const Text('Trainig Manager'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyDemandePage(title: "")),
                          );
                        },
                      )
                    : ListTile(),
                ListTile(
                  leading: Icon(
                    Icons.verified,
                  ),
                  title: const Text('Registered'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyInscritPage(
                                title: "",
                              )),
                    );
                  },
                ),
                (role.toString() == 'ROLE_RH' ||
                            role.toString() == 'ROLE_USER') ==
                        true
                    ? ListTile(
                        leading: Icon(
                          Icons.book,
                        ),
                        title: const Text('Interships'),
                        onTap: () {
                          Navigator.pushNamed(context, "/stage");
                        },
                      )
                    : ListTile(),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: const Text('log out'),
                  onTap: () {
                    AuthService.clearshared();
                    Navigator.pushNamed(context, "/");

                    // Navigator.pushNamed(context, "/formation");
                  },
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // AuthService.rolee.then((value) => {
    //       this.role = value,
    //       debugPrint(
    //           "role in init state" + (role.toString() == 'ROLE_RH').toString())

    //     });
    // debugPrint("role" + this.role);
    // return Drawer(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
    //   child: ListView(
    //     // Important: Remove any padding from the ListView.
    //     padding: EdgeInsets.all(0),
    //     children: [
    //       const DrawerHeader(
    //         decoration: BoxDecoration(
    //           color: Color(0xff3a57e8),
    //         ),
    //         child: Text('Never Stop Learning ...',
    //             style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.white)),
    //       ),
    //       DrawerHeader(
    //         decoration: BoxDecoration(
    //           color: Color(0xff3a57e8),
    //         ),
    //         child: Text(role,
    //             style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.white)),
    //       ),
    //       ListTile(
    //         leading: Icon(
    //           Icons.book,
    //         ),
    //         title: const Text('Your Trainig Courses'),
    //         onTap: () {
    //           Navigator.pushNamed(context, "/formation");
    //         },
    //       ),
    //       (role.toString() == 'ROLE_RH' || role.toString() == 'ROLE_USER') ==
    //               true
    //           ? ListTile(
    //               leading: Icon(
    //                 Icons.book,
    //               ),
    //               title: const Text('Interships'),
    //               onTap: () {
    //                 Navigator.pushNamed(context, "/stage");
    //               },
    //             )
    //           : ListTile(),
    //       ListTile(
    //         leading: Icon(
    //           Icons.logout,
    //         ),
    //         title: const Text('log out'),
    //         onTap: () {
    //           AuthService.clearshared();
    //           Navigator.pushNamed(context, "/");

    //           // Navigator.pushNamed(context, "/formation");
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
