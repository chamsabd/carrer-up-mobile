import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../modal/session.dart';
import '../modal/stage.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class StageService {
  static var client = http.Client();

  //  Future<List<Stage>> getStages() async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //   };
  //   var url = Uri.http(
  //     Config.apiURL,
  //     Config.stagesAPI,
  //   );
  //   debugPrint(url.toString() );
 
 
  //  var response  = await client.get(
  //     url
  //   );

  //   debugPrint(
  //         'movieTitle: ' + jsonDecode(response.body).toString());
      
  //   if (response.statusCode == 200) {
  //     debugPrint(
  //         'movieTitle: ' + jsonDecode(response.body).toString());
      
      
  //     var data = jsonDecode(response.body).cast<Map<String, dynamic>>();

    
  //     return data.map<Stage>((json) => Stage.fromJson(json)).toList();

  //     //return true;
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  static Future<bool> deleteStage(stageId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.stagesAPI}/$stageId");

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

  static Future<bool> saveStage(
    Stage model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var stageURL = Config.stagesAPI;

    if (isEditMode) {
      stageURL = stageURL + "/" + model.id.toString();
    }

    var url = Uri.http(Config.apiURL, stageURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    // request.fields["sujet"] = model.sujet;
    request.fields['_id'] = model.id!;
    request.fields['societe'] = model.societe;
    request.fields['sujet'] = model.sujet;
    request.fields['domaine'] = model.domaine!;
    request.fields['date_debut'] = model.datedebut as String;
    request.fields['dateFin'] = model.dateFin as String;
    request.fields['description'] = model.description;
    request.fields['available'] = model.available as String;
    request.fields['publishingdate'] = model.publishingdate as String;
    // request.fields["productPrice"] = model.productPrice!.toString();

//files or images

    // if (model.productImage != null && isFileSelected) {
    //   http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
    //     'productImage',
    //     model.productImage!,
    //   );

    //   request.files.add(multipartFile);
    // }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
