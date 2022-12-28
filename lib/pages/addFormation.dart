import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import '../services/fservice.dart';

import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../config.dart';
import '../modal/Formation.dart';
import 'FormationList.dart';

class FormationAddEdit extends StatefulWidget {
  const FormationAddEdit({Key? key}) : super(key: key);

  @override
  _FormationAddEditState createState() => _FormationAddEditState();
}

class _FormationAddEditState extends State<FormationAddEdit> {
  Formation? formation;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  bool isEditMode = false;
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NodeJS - CRUD'),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: productForm(),
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
    formation = Formation();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        formation = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget productForm() {
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
              " Name",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Formation Name can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                formation!.nom = onSavedVal,
              },
              initialValue: formation!.nom ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              prefixIcon: Icon(Icons.person),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "category",
              "Category",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Category can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                formation!.category = onSavedVal,
              },
              initialValue: formation!.category ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              prefixIcon: Icon(Icons.person),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "description",
              "Description",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return ' Description can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                formation!.description = onSavedVal,
              },
              initialValue: formation!.description ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              prefixIcon: Icon(Icons.person),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "prix",
              "Price",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Price can\'t be null.';
                }

                return null;
              },
              (onSavedVal) => {
                // formation!.prix= onSavedVal,
              },
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Save",
              () {
                if (validateAndSave()) {
                  print(formation!.toJson());

                  setState(() {
                    isApiCallProcess = true;
                  });

                  Fservice.saveFormation(
                    formation!,
                    isEditMode,
                  ).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response) {
                        // ignore: unnecessary_statements
                        () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Formationlist(),
                          ));
                          log("yesssssssssssssssssssssssssssssssssssss");
                        };
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
                        log("errrrroooorrrrrr222");
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
    } else {
      log("errorrrrrrrrrrrr");
    }
    return false;
  }
}
