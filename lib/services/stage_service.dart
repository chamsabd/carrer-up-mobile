import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../modal/session.dart';
import '../modal/stage.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class StageService {
  static var client = http.Client();

  Future<List<Stage>> getStages() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*"
    };
    var url = Uri.http(
      Config.apiURL,
      Config.stageAPI,
    );

    debugPrint(url.toString());

    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //  debugPrint(response.body.toString());

      var data = jsonDecode(response.body).cast<Map<String, dynamic>>();

      return stagesFromJson(data).toList();
    } else {
      debugPrint("nnnnn");
      throw Exception('Failed to load data');
    }
  }

  static Future<bool> deleteStage(stageId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.stageAPI}/$stageId");

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> saveStage(Stage model, bool isEditMode) async {
    debugPrint("add stage " + model.toJson().toString());

    var stageURL = Config.stageAPI;

    if (isEditMode) {
      stageURL = stageURL + "/" + model.id.toString();
    }

    var url = Uri.http(Config.apiURL, stageURL);

    var requestMethod = isEditMode ? "PUT" : "POST";
    debugPrint("requestMethod" + requestMethod.toString());
    var request = http.Request(requestMethod, url);
    final userHeader = <String, String>{
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    request.headers.addAll(userHeader);
    // request.fields["sujet"] = model.sujet;
    if (model.id != null && model.id != "") {
      // request.fields['_id'] = model.id!;
      debugPrint("id stage " + model.id.toString());
    }

  
    request.body = json.encode(model.toJson());
   
    debugPrint("id stage " + request.body.toString());


    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    debugPrint("response http " + responsed.body.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
