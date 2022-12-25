///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

import 'Formation.dart';

class DetailFormation extends StatelessWidget {
  const DetailFormation({required this.f});
  final Formation f;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 3,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          f.nom!,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Color(0xff212435),
          size: 24,
        ),
        actions: [
          Icon(Icons.search, color: Color(0xff212435), size: 24),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.favorite_border,
                        color: Color(0xff212435),
                        size: 24,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                      child: Align(
                        alignment: Alignment.center,
                        child:

                            ///***If you have exported images you must have to copy those images in assets/images directory.
                            Image(
                          image: NetworkImage(
                              "https://mbareportsguru.com/wp-content/uploads/2020/04/MBA-Marketing-Study-of-Relationship-Marketing-1.jpg"),
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              f.nom!,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      f.description!,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                      child: Text(
                        "les sessions",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: f.sessions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.blue,
                              elevation: 20,
                              shadowColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(20),
                              child: ListTile(
                                title: Text(f.sessions[index].nom!),
                                subtitle:
                                    Text("${f.sessions[index].date_debut}"),
                                leading: Text("${f.sessions[index].date_fin}"),
                                trailing: Text("${f.sessions[index].nbrplace}"),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  onPressed: () {},
                  color: Color(0xff3a57e8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xffffffff), width: 1),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Subsribe Now ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  textColor: Color(0xffffffff),
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
