import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import 'package:pflutter/services/stage_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../config.dart';
import '../modal/stage.dart';

class AddEditStage extends StatefulWidget {
  const AddEditStage({Key? key}) : super(key: key);

  @override
  _AddEditStage createState() => _AddEditStage();
}

class _AddEditStage extends State<AddEditStage> {
  Stage? stage;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add or Edit Stage'),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: stageForm(),
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
    stage = Stage();
    stage?.publishingdate = DateTime.now();
    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        stage = arguments['stage'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  String getDateD() {
    // ignore: unnecessary_null_comparison
    if (stage!.datedebut == null) {
      return 'select date';
    } else {
      return formatDate(stage!.datedebut!, [yyyy, '/', mm, '/', dd]);
    }
  }

  String getDateF() {
    // ignore: unnecessary_null_comparison
    if (stage!.dateFin == null) {
      return 'select date';
    } else {
      return formatDate(stage!.dateFin!, [yyyy, '/', mm, '/', dd]);
    }
  }

  bool showDateD = false;
  bool showDate = false;
  // Select for Date
  Future<DateTime> _selectDateD(
      BuildContext context, DateTime first, DateTime last) async {
    // stage?.dateFin ?? DateTime(2025),
    //DateTime(2000)
    final selected = await showDatePicker(
      context: context,
      initialDate: stage!.datedebut ?? DateTime.now(),
      firstDate: first,
      lastDate: last,
    );
    if (selected != null && selected != stage!.datedebut) {
      setState(() {
        stage!.datedebut = selected;
      });
    }
    return stage!.datedebut ?? DateTime.now();
  }

  Future<DateTime> _selectDateF(
      BuildContext context, DateTime first, DateTime last) async {
    // stage?.dateFin ?? DateTime(2025),
    //DateTime(2000)
    final selected = await showDatePicker(
      context: context,
      initialDate: stage!.dateFin ?? stage!.datedebut ?? DateTime.now(),
      firstDate: first,
      lastDate: last,
    );
    if (selected != null && selected != stage!.dateFin) {
      setState(() {
        stage!.dateFin = selected;
      });
    }
    return stage!.dateFin ?? DateTime.now();
  }

  Widget stageForm() {
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
              "sujet",
              "Sujet",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'sujet can\'t be empty.';
                }
                if (onValidateVal.length < 3) {
                  return 'sujet mest be at leat 3 caracters long.';
                }

                return null;
              },
              (onSavedVal) => {
                stage!.sujet = onSavedVal,
              },
              initialValue: stage!.sujet ?? "",
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
            child: FormHelper.inputFieldWidget(
              context,
              "domaine",
              "Domaine",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'domaine can\'t be empty.';
                }
                if (onValidateVal.length < 3) {
                  return 'domaine mest be at leat 3 caracters long.';
                }

                return null;
              },
              (onSavedVal) => {
                stage!.domaine = onSavedVal,
              },
              initialValue: stage!.domaine ?? "",
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
                  "datedebut",
                  "Date debut",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'date can\'t be empty.';
                    }
                    if (onValidateVal.toString() !=
                        stage!.datedebut.toString()) {
                      return 'date not correct.';
                    }
                    return null;
                  },
                  (onsave) {},
                  onChange: (text) {
                    showDateD = true;
                    _selectDateD(context, DateTime(2000),
                        stage?.dateFin ?? DateTime(2025));
                    return null;
                  },
                  initialValue: stage!.datedebut == null
                      ? ""
                      : stage!.datedebut.toString(),
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
                  "dateFin",
                  "Date fin",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'date can\'t be empty.';
                    }
                    if (onValidateVal.toString() != stage!.dateFin.toString()) {
                      return 'date not correct.';
                    }

                    return null;
                  },
                  (onsave) {},
                  onChange: (text) {
                    showDate = true;
                    _selectDateF(context, stage?.datedebut ?? DateTime(2000),
                        DateTime(2025));
                    return null;
                  },
                  initialValue:
                      stage!.dateFin == null ? "" : stage!.dateFin.toString(),
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
            child: FormHelper.inputFieldWidget(
              context,
              "description",
              "description",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'description can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                stage!.description = onSavedVal,
              },
              initialValue: stage!.description == null
                  ? ""
                  : stage!.description.toString(),
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              isMultiline: true,
            ),
          ),
         
        isEditMode?  Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.dropDownWidget(
             context,
    "Select",
    stage!.available,
    [{"label":"available","val":true},
    {"label":"not available","val":false}],
    (onChangedVal) {
        stage!.available = onChangedVal! ?? "";
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
          ):const SizedBox(
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
                  print(stage!.toJson());

                  setState(() {
                    isApiCallProcess = true;
                  });

                  StageService.saveStage(stage!, isEditMode).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      log("response " + stage!.toJson().toString());
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
