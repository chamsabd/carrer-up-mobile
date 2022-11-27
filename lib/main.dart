import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pflutter/img.dart';
import 'sessionList.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import './session.dart';
import './img.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'carrer up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = 'http://192.168.1.16:8085/SESSION-SERVER/sessions';

  List<dynamic> _sessions = [];

  bool loading = true;
  bool loading1 = true;

  @override
  void initState() {
    getsessionsFromServer();

    super.initState();
  }

  Future<void> getsessionsFromServer() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log(jsonDecode(response.body)["Sessions"].toString());
      final parsed =
          json.decode(response.body)["Sessions"].cast<Map<String, dynamic>>();
      _sessions =
          parsed.map<Session>((json) => Session.fromJson(json)).toList();
      setState(() {
        loading = !loading;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          elevation: 4,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff3a57e8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: const Text(
            " Session de Formation",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              color: Color(0xffffffff),
            ),
          ),
          actions: const [
            Icon(Icons.search, color: Color(0xffffffff), size: 22),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(Icons.dashboard, color: Color(0xffffffff), size: 22),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                    child: Text(
                      "Recent",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: _sessions.length,
                    itemBuilder: (context, position) {
                      return Card(
                        child: InkWell(
                            // onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               SecondWidget(Sessions[position])));
                            // },
                            child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: loading
                              ? waitingScreen()
                              : SessionL(_sessions[position]),
                        )),
                      );
                    },
                  ),
                ]))));
  }

  Widget waitingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("Loading data ..."),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
