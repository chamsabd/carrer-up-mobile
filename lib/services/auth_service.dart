import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modal/Role.dart';
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
      "Accept": "*/*",
      "Access-Control-Allow-Origin": "*"
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
      "Accept": "*/*",
      "Access-Control-Allow-Origin": "*"
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
      "Accept": "*/*",
      "Access-Control-Allow-Origin": "*"
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
      return {"erreur": e, "statusCode": 3000};
    }
  }

  get role async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? "";
  }
 static clearshared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }


  Future<String> roles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? "";
  }

  static Future<Map<String, dynamic>> validate() async {
    var url = Uri.http(Config.apiURL, Config.validateAPI);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    String role = prefs.getString('role') ?? "";

    //var request = http.Request(requestMethod, url);
    final userHeader = <String, String>{
      "Content-type": "application/json",
      "Accept": "*/*",
      "Authorization": token,
      "Access-Control-Allow-Origin": "*"
    };
    // request.headers.addAll(userHeader);
    // request.body = json.encode(model.toJson());

    try {
      var responsed = await http.get(url, headers: userHeader);

      if (responsed.statusCode == 200) {
        return {"logedin": true, "role": role};
      } else {
        return {
          "logedin": false,
        };
      }
    } catch (e) {
      return {
        "logedin": false,
      };
    }
  }

  // Future<List<User>> getall() async {
  //   var url = Uri.http(Config.apiURL, Config.GetAllUsersAPI);
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token') ?? "";
  //   final userHeader = <String, String>{
  //     "Content-type": "application/json",
  //     "Accept": "*/*",
  //     "Access-Control-Allow-Origin": "*",
  //     "Authorization": token
  //   };

  //   try {
  //     var responsed = await client.get(url, headers: userHeader);

  //     if (responsed.statusCode == 200) {
  //       //  var data = jsonDecode(responsed.body).cast<Map<String, dynamic>>();
  //       final parsed = jsonDecode(responsed.body).cast<Map<String, dynamic>>();
  //       debugPrint("avant " + parsed.toString());
  //       //  Map<String, dynamic> data = json.decode(responsed.body);
  //       // List<User> users = [];

  //       // List<User> users = [];

  //       // debugPrint("avant " + parsed.length.toString());
  //       // for (var i = 0; i < parsed.length; i++) {
  //       //   debugPrint("innn");
  //       //   User u = new User();
  //       //   u.id = parsed[i]['id'].toString();
  //       //   u.nom = parsed[i]['nom'].toString();
  //       //   u.prenom = parsed[i]['prenom'].toString();
  //       //   u.email = parsed[i]['email'].toString();
  //       //   debugPrint("roles " + parsed[i]['roles'].length.toString());

  //       //   List<Role> r = [];
  //       //   for (var j = 0; j < parsed[i]['roles'].length; j++) {
  //       //     Role ro = new Role();
  //       //     ro.id = parsed[j]['id'];
  //       //     ro.name = parsed[j]['name'];

  //       //     r.add(ro);
  //       //   }

  //       //   u.roles = r;

  //       //   users.add(u);
  //       // }
  //       // for (var u in parsed) {
  //       //   debugPrint("user  " + u.toString());
  //       //   User user = u;
  //       //   users.add(user);
  //       // }
  //       // return users;
  //       //   debugPrint("user  " + users.toString());
  //       // usersFromJson(parsed).toList() parsed.map((i) => User.fromJson(i)).toList()
  //       // parsed.map<User>((json) => User.fromJson(json)).toList();
  //       return usersFromJson(parsed);
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load data');
  //   }
  // }

static Future<List<User>> getall() async {
    //var response = await http.get(Uri.parse(url));
final SharedPreferences prefs = await SharedPreferences.getInstance();
     String token=  prefs.getString('token')??"";

    Map<String, String> requestHeaders = {'content-type': 'application/json',
    'Authorization':token};
    var url = Uri.http(Config.apiURL, Config.GetAllUsersAPI);
    // ignore: close_sinks
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      
      //log(jsonDecode(response.body)["content"].toString());
      final parsed = jsonDecode(response.body)as List;

      return parsed.map<User>((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }



  Future<Map<String, dynamic>> updateuser(User model, bool isEditMode) async {
    var stageURL = Config.GetAllUsersAPI;

    var url = Uri.http(Config.apiURL, stageURL);

    var requestMethod = "PUT";

    var request = http.Request(requestMethod, url);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";

    Map<String, String> userHeader = {
      'content-type': 'application/json',
      'Authorization': token
    };

    request.headers.addAll(userHeader);
    // request.fields["sujet"] = model.sujet;
    if (model.id != null && model.id != "") {
      // request.fields['_id'] = model.id!;
    }

    request.body = json.encode(model.toJson());
    try {
      var response = await request.send();
      // var responsed = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        return {'message': "done !", "statusCode": response.statusCode};
      } else {
        return {
          "erreur": "Unauthorized!",
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      debugPrint(e.toString());
      return {"erreur": e, "statusCode": 3000};
    }
  }
}
