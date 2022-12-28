import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pflutter/pages/stageitem.dart';

import 'package:pflutter/services/stage_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';
import '../modal/stage.dart';

class Stages extends StatefulWidget {
  Stages({super.key});

  @override
  State<Stages> createState() => _StageState();
}

class _StageState extends State<Stages> {
  bool isApiCallProcess = false;
  var stageService = StageService();
  var _isShown = false;
  List<dynamic> stages = [];
  @override
  void initState() {
    //  getStages();
    super.initState();
  }

  static var client = http.Client();

  // Future<void> getStages() async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     "Access-Control-Allow-Origin": "*"
  //   };
  //   var url = 'http://192.168.1.8:8085/STAGE-SERVER/stages';
  //   var uri = Uri.http(
  //     Config.apiURL,
  //     Config.stageAPI,
  //   );

  //   debugPrint(url.toString());

  //   var response = await http.get(uri, headers: requestHeaders);

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body).cast<Map<String, dynamic>>();
  //     stages = data.map<Stage>((json) => Stage.fromJson(json)).toList();
  //     debugPrint("id stage " + stages[0].id.toString());
  //   } else {
  //     debugPrint("nnnnn");
  //     throw Exception('Failed to load data');
  //   }
  // }

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
        leading: const Icon(
          Icons.arrow_back,
          color: Color(0xff212435),
          size: 24,
        ),
      ),
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadProducts(),
      ),
    );
  }

  Widget loadProducts() {
    // stages =  stageService.getStages() ;
    debugPrint('data: ' + stages.toString());
    // if (stages!=[]) {

    //   return list(stages);
    // } else {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
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
              ElevatedButton(
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
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: stages.length,
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return stageitem(
                      stage: stages[index],
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
