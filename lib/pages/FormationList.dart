import 'package:flutter/material.dart';

import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../modal/Formation.dart';
import 'drawer.dart';
import 'itemFormation.dart';

import '../services/fservice.dart';

class Formationlist extends StatefulWidget {
  const Formationlist({Key? key}) : super(key: key);

  @override
  _FormationlistState createState() => _FormationlistState();
}

class _FormationlistState extends State<Formationlist> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
        new GlobalKey<ScaffoldState>();
  // List<Formation> products = List<Formation>.empty(growable: true);
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 4,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff3a57e8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: Text(
            "CarrerUp",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              //on drawer menu pressed
              if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
                //if drawer is open, then close the drawer
                Navigator.pop(context);
              } else {
                _drawerscaffoldkey.currentState!.openDrawer();
                //if drawer is closed then open the drawer.
              }
            },
            icon: Icon(Icons.menu),
          ), // Set menu icon at leading of AppBar
        ),
        key: _drawerscaffoldkey,
        drawer: drawer(),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        child: loadProducts(),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }

  Widget loadProducts() {
    return FutureBuilder<List<Formation>>(
      future: Fservice.fetchFormations(),
      initialData: [],
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Formation>?> model,
      ) {
        if (model.hasData) {
          return productList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productList(_formations) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.green,
                  minimumSize: const Size(88, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/add-product',
                  );
                },
                child: const Text('Add Product'),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _formations.length,
                itemBuilder: (context, index) {
                  return FormationItem(
                    model: _formations[index],
                    onDelete: (Formation model) {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      Fservice.deleteFormation(model.id).then(
                        (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
