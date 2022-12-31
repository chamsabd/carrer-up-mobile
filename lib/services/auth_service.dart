import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modal/User.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class AuthService {
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

  static Future<Map<String, dynamic>> login(User model) async {
    var url = Uri.http(Config.apiURL, Config.loginAPI);

    //var request = http.Request(requestMethod, url);
    final userHeader = <String, String>{
      "Content-type": "application/json",
      "Accept": "*/*"
    };
    // request.headers.addAll(userHeader);
    // request.body = json.encode(model.toJson());
    debugPrint("user " + model.toJson().toString());
    var time1 = DateTime.now().millisecondsSinceEpoch;
    try {
      var responsed = await http.post(url,
          body: json.encode(model.toJson()), headers: userHeader);
      debugPrint("user " + responsed.body.toString());

      debugPrint("stauscode " + responsed.statusCode.toString());

      if (responsed.statusCode == 200) {
        var map = jsonDecode(responsed.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', map['tokenType'] + " " + map['accessToken']);
        prefs.setString('role', map['roles']);
        prefs.setString('id', map['id']);
        prefs.setString('username', map['username']);
        prefs.setString('email', map['email']);
        return {"statusCode": responsed.statusCode};
      } else {
        try {
          var map = jsonDecode(responsed.body);
          debugPrint("stauscode " + responsed.statusCode.toString());
          String message = map['message'] ?? "unauthorized";
          return {
            'message': message,
            "statusCode": responsed.statusCode,
          };
        } catch (e) {
          String message = "unauthorized";
          return {
            'message': message,
            "statusCode": responsed.statusCode,
          };
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      print(DateTime.now().millisecondsSinceEpoch - time1); // Print about 13s
      return {"erreur": e, "statusCode": 3000};
    }
  }

  static Future<bool> validate() async {
    var url = Uri.http(Config.apiURL, Config.validateAPI);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    debugPrint("validate " + token);
    //var request = http.Request(requestMethod, url);
    final userHeader = <String, String>{
      "Content-type": "application/json",
      "Accept": "*/*",
      "Authorization": token
    };
    // request.headers.addAll(userHeader);
    // request.body = json.encode(model.toJson());

    try {
      var responsed = await http.get(url, headers: userHeader);

      if (responsed.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
