import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:vrouter/vrouter.dart';
import '../modal/user.dart';

class usersitem extends StatelessWidget {
  final User user;
  final String role;


  usersitem({
    Key? key,
    required this.user,
     required this.role,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      color: Color(0xffffffff),
      shadowColor: Color(0xff000000),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: cartItem(context),
    );

    //  Card(
    //   elevation: 0,
    //   margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    //   child: Container(
    //     width: 200,
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(50),
    //     ),
    //     child: cartItem(context),
    //   ),
    // );
  }

  Widget cartItem(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(children: [
                  Text(
                    "${user.nom}  ${user.prenom}",
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                 
                ]),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(
                    "${user.email}",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                      color: Color(0xff7a7a7a),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(
                    user.email.toString(),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ),
        Container(

            //width: MediaQuery.of(context).size.width - 180,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          GestureDetector(
            child: const Icon(Icons.edit),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/add-user',
                arguments: {
                  'user': user,
                },
              );
            },
          )
        ])),
      ],
    );

    // Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             " ${user.sujet}",
    //             style: const TextStyle(
    //               color: Colors.black,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           Text(
    //             " ${user.datedebut} ${user.dateFin}",
    //             style: const TextStyle(color: Colors.black),
    //           ),

    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
