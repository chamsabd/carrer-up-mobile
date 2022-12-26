import 'package:flutter/material.dart';
import 'package:pflutter/Demande.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:http/http.dart' as http;

class MyInscritPage extends StatefulWidget {
  const MyInscritPage({super.key, required this.title});

  final String title;

  @override
  State<MyInscritPage> createState() => _MyInscritPageState();
}

class _MyInscritPageState extends State<MyInscritPage> {
  final String url = 'http://192.168.1.6:8085/INSCRIT-SERVICE/inscrit/accepted';

  List<dynamic> _inscrits = [];
  bool loading = true;
  @override
  void initState() {
    fetchInscrits();

    super.initState();
  }

  Future<void> fetchInscrits() async {
    var response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      _inscrits =
          parsed.map<Demande>((json) => Demande.fromJson(json)).toList();
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
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffffffff),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: const Text(
            "Registered",
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
      itemCount: _inscrits.length,
      itemBuilder: (context, index) {
        Demande todo = _inscrits[index];
        return Card(
            child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 14),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0x4d9e9e9e), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.check,
                color: Color(0xff3a57e8),
                size: 40,
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
            ],
          ),
        ));
      },
    );
  }
}
