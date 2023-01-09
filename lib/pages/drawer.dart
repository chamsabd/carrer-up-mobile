///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:pflutter/services/auth_service.dart';
import './signup.dart';

import 'categories.dart';

class drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
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
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Categories'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => categories()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.start,
            ),
            title: const Text('Interships'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.book,
            ),
            title: const Text('Your Trainig Courses'),
            onTap: () {
              Navigator.pushNamed(context, "/formation");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.book,
            ),
            title: const Text('Stages'),
            onTap: () {
              Navigator.pushNamed(context, "/stage");
            },
          ),
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
}
