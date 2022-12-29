import 'dart:convert';

import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../modal/User.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class SignUPService {
  static var client = http.Client();

  static Future<Map<String, dynamic>> code(User model) async {
    debugPrint("add user " + model.toJson().toString());

    var url = Uri.http(Config.apiURL, Config.codeAPI);
    debugPrint("add user " + url.toString());

    var requestMethod = "POST";

    var request = http.Request(requestMethod, url);
    final userHeader = <String, String>{
      "Content-type": "application/json",
      "Accept": "*/*"
    };
    request.headers.addAll(userHeader);
    request.body = json.encode(model.toJson());
    debugPrint("add user " + request.body.toString());
    var time1 = DateTime.now().millisecondsSinceEpoch;
    try {
      var responsed = await http.post(url,
          body: json.encode(model.toJson()), headers: userHeader);
      // var response = await request.send();
      // print(DateTime.now().millisecondsSinceEpoch - time1); // Print about 13s
      // var responsed = await http.Response.fromStream(response);
      print(responsed.body.toString());
      var map = jsonDecode(responsed.body); // Print about 13s
      if (responsed.statusCode == 200) {
// import 'dart:convert';
        String? message = map['message'];
        print("ok");
        return {'message': message, "statusCode": responsed.statusCode};
      } else {
        print(map['errors']);
        List<dynamic> erreur = map['errors'];
        print("else");
        String? erreurf = erreur[0]['defaultMessage'];
        print("else");
        String? fiels = erreur[0]['field'];
        return {
          "erreur": erreurf,
          "statusCode": responsed.statusCode,
          "fiels": fiels
        };
      }
    } catch (e) {
      debugPrint(e.toString());
      print(DateTime.now().millisecondsSinceEpoch - time1); // Print about 13s
      return {"erreur": e, "statusCode": 3000};
    }
    // var response = await request.send();
    // var responsed = await http.Response.fromStream(response);
    // debugPrint("response http " + responsed.toString());
    // if (response.statusCode == 200) {
    //   return responsed.body;
    // } else {
    //   return "false";
    // }
  }

  static Future<Map<String, dynamic>> save(User model) async {
    
    var url = Uri.http(Config.apiURL, Config.signupAPI);
   
    var requestMethod = "POST";

    var request = http.Request(requestMethod, url);
    final userHeader = <String, String>{
      "Content-type": "application/json",
      "Accept": "*/*"
    };
    request.headers.addAll(userHeader);
    request.body = json.encode(model.toJson());
    
    var time1 = DateTime.now().millisecondsSinceEpoch;
    try {
      var responsed = await http.post(url,
          body: json.encode(model.toJson()), headers: userHeader);
      
      print(responsed.body.toString());
      var map = jsonDecode(responsed.body); 
      if (responsed.statusCode == 200) {

        String? message = map['message'];
        print("ok");
        return {'message': message, "statusCode": responsed.statusCode};
      } else {
        print(map['errors']);
        List<dynamic> erreur = map['errors'];
        print("else");
        String? erreurf = erreur[0]['defaultMessage'];
        print("else");
        String? fiels = erreur[0]['field'];
        return {
          "erreur": erreurf,
          "statusCode": responsed.statusCode,
          "fiels": fiels
        };
      }
    } catch (e) {
      debugPrint(e.toString());
      print(DateTime.now().millisecondsSinceEpoch - time1); // Print about 13s
      return {"erreur": e, "statusCode": 3000};
    }
    // var response = await request.send();
    // var responsed = await http.Response.fromStream(response);
    // debugPrint("response http " + responsed.toString());
    // if (response.statusCode == 200) {
    //   return responsed.body;
    // } else {
    //   return "false";
    // }
  }
}
