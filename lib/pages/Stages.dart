import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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

  List<Stage> stages = [];
  @override
  void initState() {
    super.initState();
    getStages();
  }

  static var client = http.Client();

  Future<void> getStages() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    "Access-Control-Allow-Origin": "*"
    };
    var url = Uri.http(
      Config.apiURL,
      Config.stagesAPI,
    );
     const String ur = 'http://192.168.1.8:8085/STAGE-SERVER/stages';

    debugPrint(url.toString());

    var response = await http.get(Uri.parse(ur),headers: requestHeaders) ;
  
 

    if (response.statusCode == 200) {
     
 debugPrint("okkk");
      // var data = jsonDecode(response.body).cast<Map<String, dynamic>>();

      // stages = data.map<Stage>((json) => Stage.fromJson(json)).toList();

      //return true;
    } else {
       debugPrint("nnnnn");
      throw Exception('Failed to load data');
    }
  }

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
    // stages =  StageService.getStages() ;
    if (stages!=[]) {
   debugPrint('data: ' + stages.toString());
      return list(stages);
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    // return FutureBuilder(
    //   future: stageService.getStages(),
    //   builder: (
    //     BuildContext context,
    //     AsyncSnapshot<List<Stage>?> model,
    //   ) {
    //     debugPrint("data  : " + model.data.toString());

    //     if (model.hasData) {
    //       debugPrint("data  : " + model.data!.toString());

    //       return list(model.data);
    //     }

    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }

  Widget list(stages) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Card(
          margin: EdgeInsets.all(0),
          color: Color(0xffffffff),
          shadowColor: Color(0xff000000),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0)),
                child:

                    ///***If you have exported images you must have to copy those images in assets/images directory.
                    Image(
                  image: NetworkImage(
                      "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=85,metadata=none,w=400,h=400/app/images/products/full_screen/pro_86973.jpg"),
                  height: 130,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Veg Frankie Roll",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: Text(
                          "In Signature Wraps",
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
                          "\$26",
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
                          "Signature wraps packe with double protein.",
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
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.more_vert,
                  color: Color(0xff212435),
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
