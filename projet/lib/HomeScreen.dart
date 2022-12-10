///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

import 'formationMain.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        ),
        body: SafeArea(child: FormationPage(title: "Listes des formations"))
/*bottomNavigationBar: BottomNavigationBar(
items: flutterVizBottomNavigationBarItems.map((FlutterVizBottomNavigationBarModel item) {
return BottomNavigationBarItem(
icon: Icon(item.icon),
label: item.label
, );
 }).toList(),
backgroundColor: Color(0xffffffff),
currentIndex: 0,
elevation: 8,
iconSize: 24,
selectedItemColor: Color(0xff3a57e8),
unselectedItemColor: Color(0xff9e9e9e),
selectedFontSize: 14,
unselectedFontSize:14,
showSelectedLabels: true,
showUnselectedLabels: true,
onTap: (value){},
),
*/

        );
  }
}
