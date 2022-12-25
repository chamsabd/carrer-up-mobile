///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:flutterviz/FormationDetail.dart';

import 'Formation.dart';

class FormationList extends StatelessWidget {
  FormationList({required this.f});
  final Formation f;
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Card(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
            color: Color.fromARGB(255, 153, 198, 252),
            shadowColor: Color(0x4d939393),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              f.nom!,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color.fromARGB(255, 149, 163, 240),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                              child: Text(
                                f.category!,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  color: Color(0xff6c6c6c),
                                ),
                              ),
                            ),
                            Text(
                              "${f.prix}",
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff6c6c6c),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailFormation(f: f),
            ),
          );
        });
  }
}
