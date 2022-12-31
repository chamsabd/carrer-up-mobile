import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../modal/Demande.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:http/http.dart' as http;

class MyDemandePage extends StatefulWidget {
  const MyDemandePage({super.key, required this.title});

  final String title;

  @override
  State<MyDemandePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyDemandePage> {
  //final String url = 'http://192.168.1.6:8085/INSCRIT-SERVICE/inscrit';
var url = Uri.http(Config.apiURL, Config.inscritAPI);
  List<dynamic> _demandes = [];
  bool loading = true;
  @override
  void initState() {
    fetchDemandes();

    //accepter();
    // refuser();
    super.initState();
  }

  Future<void> fetchDemandes() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
     String token=  prefs.getString('token')??"";

    var response = await http.get(
     url ,
     headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization':token
            },
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      _demandes =
          parsed.map<Demande>((json) => Demande.fromJson(json)).toList();
      setState(() {
        loading = !loading;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Demande> accepter(String id) async {
    var url = Uri.http(Config.apiURL, Config.inscritAPI+"/accept");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
     String token=  prefs.getString('token')??"";

    final response =
        await http.put(url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization':token
            },
            body: jsonEncode(<String, String>{
              'etat': "accepted",
              'id': id,
            }));

    if (response.statusCode == 200) {
      setState(() {
        int trendIndex = _demandes.indexWhere((f) => f.id == id);
        _demandes[trendIndex].etat = "accepted";
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Demand accepted'),
            backgroundColor: Colors.green,
          ),
        );
      });
      return Demande.fromJson(jsonDecode(response.body));
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No More Places'),
            backgroundColor: Colors.red,
          ),
        );
      });
      throw Exception('Failed to update demand');
    }
  }

  Future<Demande> refuser(String id) async {
     var url = Uri.http(Config.apiURL, Config.inscritAPI+"/refuse");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
     String token=  prefs.getString('token')??"";

   
    var response =
        await http.put(url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization':token
            },
            body: jsonEncode(<String, String>{
              'etat': "refused",
              'id': id,
            }));

    if (response.statusCode == 200) {
      setState(() {
        int trendIndex = _demandes.indexWhere((f) => f.id == id);
        _demandes[trendIndex].etat = "refused";
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Demand Refused'),
            backgroundColor: Colors.red,
          ),
        );
      });
      return Demande.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update demand');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffffffff),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: const Text(
            "Training Demand",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              color: Color(0xff000000),
            ),
          ),
          leading: const Icon(
            Icons.arrow_back,
            color: Color(0xff212435),
            size: 24,
          ),
        ),
        body: loading ? waitingScreen() : todosList()
        /*  floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.grey,
      ),*/

        /* bottomNavigationBar: BottomAppBar(
          notchMargin: 5.0,
          shape: const CircularNotchedRectangle(),
          color: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: const [
                  Icon(Icons.home, color: Colors.white),
                  Text(
                    "home",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: const [
                  Icon(Icons.grid_view, color: Colors.white),
                  Text(
                    "demandes",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: const [
                  Icon(Icons.account_circle_outlined, color: Colors.white),
                  Text(
                    "account",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ],
          )),*/
        );
  }

  Widget waitingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("loading data ..."),
          Padding(padding: EdgeInsets.only(bottom: 25)),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget todosList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(15),
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: _demandes.length,
      itemBuilder: (context, index) {
        Demande todo = _demandes[index];
        return Card(
            child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 14),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0x4d9e9e9e), width: 3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.send,
                color: Color(0xff3a57e8),
                size: 30,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      // if (todo.idSession==formation.id)
                      Text(
                        "Training name : ${todo.idSession} ",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          "Date : ${todo.date}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    if (todo.etat == "accepted")
                      const Text("accepted",
                          style: TextStyle(
                            color: Colors.green,
                          )),
                    if (todo.etat == "refused")
                      const Text("refused",
                          style: TextStyle(
                            color: Colors.red,
                          )),
                    if (todo.etat == "In progress")
                      ElevatedButton(
                        child: Text(todo.etat),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Are you Sure To Accept or refuse this Demande !",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        backgroundColor: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white),
                                      onPressed: (() {
                                        refuser(todo.id);
                                        Navigator.pop(context);
                                      }),
                                      child: const Text(
                                        "Refus",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white),
                                      onPressed: (() {
                                        accepter(todo.id);
                                        Navigator.pop(context);
                                      }),
                                      child: const Text(
                                        "Accept",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                  ]),
            ],
          ),
        ));
      },
    );
  }
}
/* ElevatedButton(
                    child: Text(todo.etat),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Are you Sure To Accept or refuse This Demandes !",
                                style: TextStyle(
                                    color: Colors.grey,
                                    backgroundColor: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white),
                                  onPressed: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: const Text(
                                    "Refuse",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white),
                                  onPressed: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: const Text(
                                    "Accept",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                  ), */