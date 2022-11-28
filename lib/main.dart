import 'package:flutter/material.dart';
import 'package:flutter_project/Demande.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
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
  final String url = 'http://192.168.1.7:8085/DEMANDE-SERVER/demandes';

  List<dynamic> _demandes = [];
  bool loading = true;
  @override
  void initState() {
    fetchDemandes();
    super.initState();
  }

  Future<void> fetchDemandes() async {
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      log(jsonDecode(response.body)["content"].toString());
      log("helloo");
      final parsed =
          json.decode(response.body)["content"].cast<Map<String, dynamic>>();
      log(parsed.toString());
      _demandes =
          parsed.map<Demande>((json) => Demande.fromJson(json)).toList();
      log("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      log(_demandes.toString());
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: loading ? waitingScreen() : todosList(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {},
            alignment: const Alignment(0.7, 0.0),
            color: Color(0xff212435),
            iconSize: 24,
          )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: "Demandes",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Stages",
            icon: Icon(Icons.grid_view),
          ),
          BottomNavigationBarItem(
            label: "Comptes",
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
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

  Widget todosList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: _demandes.length,
      itemBuilder: (context, index) {
        Demande todo = _demandes[index];
        return Card(
            child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 14),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Color(0x4d9e9e9e), width: 5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.article,
                color: Color(0xff3a57e8),
                size: 50,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    todo.idSession.toString(),
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
                                ),
                                /* Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 8),
                                  child: Icon(
                                    Icons.push_pin,
                                    color: Color(0xffffac00),
                                    size: 20,
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          /*  Icon(
                            Icons.more_horiz,
                            color: Color(0xff212435),
                            size: 20,
                          ),*/
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                todo.date.toString(),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff393939),
                                ),
                              ),
                            ),
                            /*  Container(
                              margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Color(0x343a57e8),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen,
                    ),
                    child: Text(
                      "accept",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                    child: Text(
                      "refuse",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
      },
    );
  }
}
