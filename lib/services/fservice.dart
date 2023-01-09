import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/Formation.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class Fservice {
  List<Formation> _formations = [];

  static var client = http.Client();
  static Future<List<Formation>> fetchFormations() async {
    //var response = await http.get(Uri.parse(url));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";

    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'Authorization': token
    };
    var url = Uri.http(Config.apiURL, Config.formationUrl);
    // ignore: close_sinks
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      
      //log(jsonDecode(response.body)["content"].toString());
      final parsed = jsonDecode(response.body)["content"] as List;
      log(parsed.toString());
     

      return parsed.map<Formation>((json) => Formation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<bool> saveFormation(Formation f, bool isEditMode) async {
    var furl = Config.formationUrl;

    if (isEditMode) {
      furl = furl + "/" + f.id.toString();
    }
    var url = Uri.http(Config.apiURL, furl);
    var requestMethod = isEditMode ? "PUT" : "POST";
    var request = http.Request(requestMethod, url);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";

    Map<String, String> userHeader = {
      'content-type': 'application/json',
      'Authorization': token
    };

    request.headers.addAll(userHeader);
    // request.fields["sujet"] = model.sujet;
    if (f.id != null && f.id != "") {
      // request.fields['_id'] = model.id!;
      debugPrint("id stage " + f.id.toString());
    }

    request.body = json.encode(f.toJson());
    debugPrint("id stage " + request.body.toString());

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      log("goooooooooooood");
      return true;
    } else {
      log("errrrooooo3");
      return false;
    }
  }

  static Future<bool> deleteFormation(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";

    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'Authorization': token
    };

    var url = Uri.http(Config.apiURL, Config.formationUrl + "/" + id);
    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      log("deleted successfully");
      return true;
    } else
      return false;
  }
}
