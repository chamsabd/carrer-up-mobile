import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import '../modal/stage.dart';

class stageitem extends StatelessWidget {
  final Stage stage;
  final Function? onDelete;

  stageitem({
    Key? key,
    required this.stage,
    this.onDelete,
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
                    "${stage.societe} | sujet: ${stage.sujet}",
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
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: stage.available == true
                          ? Color.fromARGB(255, 26, 223, 4)
                          : Color.fromARGB(255, 249, 0, 0),
                      shape: BoxShape.circle,
                    ),
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(
                    "${stage.domaine}",
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
                    formatDate(stage.datedebut!, [yyyy, '/', mm, '/', dd]) +
                        " | " +
                        formatDate(stage.dateFin!, [yyyy, '/', mm, '/', dd]),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    "${stage.description} ",
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 11,
                      color: Color(0xff000000),
                    ),
                  ),
                )
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
                '/add-stage',
                arguments: {
                  'stage': stage,
                },
              );
            },
          ),
          GestureDetector(
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onTap: () {
              onDelete!(stage);
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
    //             " ${stage.sujet}",
    //             style: const TextStyle(
    //               color: Colors.black,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           Text(
    //             " ${stage.datedebut} ${stage.dateFin}",
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
