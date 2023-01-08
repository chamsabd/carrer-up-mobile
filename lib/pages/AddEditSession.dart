import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import 'package:pflutter/services/stage_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../config.dart';
import '../modal/Session.dart';
import '../services/sessionService.dart';

class AddEditSession extends StatefulWidget {
  const AddEditSession({Key? key}) : super(key: key);

  @override
  _AddEditSession createState() => _AddEditSession();
}

class _AddEditSession extends State<AddEditSession> {
  Session? session;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add or Edit session'),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: sessionForm(),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    session = Session();
    //session?.publishingdate = DateTime.now();
    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        session = arguments['session'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  String getDateD() {
    // ignore: unnecessary_null_comparison
    if (session!.date_debut == null) {
      return 'select date';
    } else {
      return formatDate(session!.date_debut!, [yyyy, '/', mm, '/', dd]);
    }
  }

  String getDateF() {
    // ignore: unnecessary_null_comparison
    if (session!.date_fin == null) {
      return 'select date';
    } else {
      return formatDate(session!.date_fin!, [yyyy, '/', mm, '/', dd]);
    }
  }

  bool showDateD = false;
  bool showDate = false;
  // Select for Date
  Future<DateTime> _selectDateD(
      BuildContext context, DateTime first, DateTime last) async {
    // session?.date_fin ?? DateTime(2025),
    //DateTime(2000)
    final selected = await showDatePicker(
      context: context,
      initialDate: session!.date_debut ?? DateTime.now(),
      firstDate: first,
      lastDate: last,
    );
    if (selected != null && selected != session!.date_debut) {
      setState(() {
        session!.date_debut = selected;
      });
    }
    return session!.date_debut ?? DateTime.now();
  }

  Future<DateTime> _selectDateF(
      BuildContext context, DateTime first, DateTime last) async {
    // session?.date_fin ?? DateTime(2025),
    //DateTime(2000)
    final selected = await showDatePicker(
      context: context,
      initialDate: session!.date_fin ?? session!.date_debut ?? DateTime.now(),
      firstDate: first,
      lastDate: last,
    );
    if (selected != null && selected != session!.date_fin) {
      setState(() {
        session!.date_fin = selected;
      });
    }
    return session!.date_fin ?? DateTime.now();
  }

  Widget sessionForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "nom",
              "nom",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'nom can\'t be empty.';
                }
                if (onValidateVal.length < 3) {
                  return 'nbrplace mest be at leat 3 caracters long.';
                }

                return null;
              },
              (onSavedVal) => {
                session!.nbrplace = onSavedVal,
              },
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                top: 10,
              ),
              child: InkWell(
                onTap: () {},
                child: FormHelper.inputFieldWidget(
                  context,
                  "date_debut",
                  "Date debut",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'date can\'t be empty.';
                    }
                    if (onValidateVal.toString() !=
                        session!.date_debut.toString()) {
                      return 'date not correct.';
                    }
                    return null;
                  },
                  (onsave) {},
                  onChange: (text) {
                    showDateD = true;
                    _selectDateD(context, DateTime(2000),
                        session?.date_fin ?? DateTime(2025));
                    return null;
                  },
                  initialValue: session!.date_debut == null
                      ? ""
                      : session!.date_debut.toString(),
                  obscureText: false,
                  borderFocusColor: Colors.black,
                  borderColor: Colors.black,
                  textColor: Colors.black,
                  hintColor: Colors.black.withOpacity(0.7),
                  borderRadius: 10,
                  showPrefixIcon: false,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                top: 10,
              ),
              child: InkWell(
                onTap: () {},
                child: FormHelper.inputFieldWidget(
                  context,
                  "date_fin",
                  "Date fin",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'date can\'t be empty.';
                    }
                    if (onValidateVal.toString() !=
                        session!.date_fin.toString()) {
                      return 'date not correct.';
                    }

                    return null;
                  },
                  (onsave) {},
                  onChange: (text) {
                    showDate = true;
                    _selectDateF(context, session?.date_debut ?? DateTime(2000),
                        DateTime(2025));
                    return null;
                  },
                  initialValue: session!.date_fin == null
                      ? ""
                      : session!.date_fin.toString(),
                  obscureText: false,
                  borderFocusColor: Colors.black,
                  borderColor: Colors.black,
                  textColor: Colors.black,
                  hintColor: Colors.black.withOpacity(0.7),
                  borderRadius: 10,
                  showPrefixIcon: false,
                ),
              )),
          isEditMode
              ? Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                  ),
                  child: FormHelper.dropDownWidget(
                    context,
                    "Select",
                    session!.etat,
                    [
                      {"label": "available", "val": true},
                      {"label": "not available", "val": false}
                    ],
                    (onChangedVal) {
                      session!.etat = onChangedVal! ?? "";
                    },
                    (onValidateVal) {
                      if (onValidateVal == null) {
                        return 'Please Select ';
                      }

                      return null;
                    },
                    optionValue: "val",
                    optionLabel: "label",
                    borderFocusColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    borderRadius: 10,
                  ),
                )
              : const SizedBox(
                  height: 5,
                ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Save",
              () {
                if (validateAndSave()) {
                  print(session!.toJson());

                  setState(() {
                    isApiCallProcess = true;
                  });

                  SessionService.saveSession(session!, isEditMode).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      log("response " + session!.toJson().toString());
                      if (response) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Error occur",
                          "OK",
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  );
                }
              },
              btnColor: HexColor("283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  isValidURL(url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }
}
