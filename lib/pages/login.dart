///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pflutter/modal/User.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../config.dart';

import '../services/auth_service.dart';
import './signup.dart';
import 'package:email_validator/email_validator.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _login();
}

class _login extends State<login> {
  //final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // AuthService.validate().then((response) {
    //   if (response) {
    //     Navigator.of(context).pushNamed('/formation');
    //   } else {}
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6e6e6),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35000000000000003,
            decoration: BoxDecoration(
              color: Color(0xff3a57e8),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Color(0x4d9e9e9e), width: 1),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 100, 20, 20),
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Carrer Up",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 40,
                        color: Color(0xff000000),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 22,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    MyCustomForm(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: Text(
                              "Don't have an account?",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/signup');
                            },
                            child: Text("SignUp",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff3a57e8),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  var user = User();
  IconData? iconp = Icons.visibility_off;

  bool p = true;

  void _changepas() {
    setState(() {
      if (p) {
        iconp = Icons.visibility_outlined;
        p = false;
      } else {
        iconp = Icons.visibility_off;
        p = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              child: TextFormField(
                obscureText: false,
                textAlign: TextAlign.start,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                decoration: InputDecoration(
                  disabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Color(0xff000000), width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Color(0xff000000), width: 1),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Color(0xff000000), width: 1),
                  ),
                  labelText: "User Name",
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                  hintText: "Enter Text",
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  filled: true,
                  fillColor: const Color(0xffffffff),
                  isDense: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  prefixIcon: const Icon(Icons.person,
                      color: Color(0xff000000), size: 24),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (!EmailValidator.validate(value.toString(), true, false)) {
                    return 'Please Enter a Valid Email';
                  }
                  return null;
                },
                onChanged: (value) {
                  user.username = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: TextFormField(
                obscureText: p,
                textAlign: TextAlign.start,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                    hintText: "Enter Text",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    filled: true,
                    fillColor: Color(0xffffffff),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    suffixIcon: IconButton(
                      onPressed: _changepas,
                      icon: Icon(iconp, color: Color(0xff212435), size: 24),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length < 6) {
                    return 'at least 6 caracters';
                  }
                  return null;
                },
                onChanged: (value) {
                  user.password = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AuthService.login(user).then(
                      (response) {
                        debugPrint(response.toString());
                        var c = response as Map<String, dynamic>;
                        var d = c["statusCode"] as int;
                        if (d == 200) {
                          Navigator.of(context).pushNamed('/formation');
                        } else {
                          FormHelper.showSimpleAlertDialog(
                            context,
                            Config.appName,
                            c["erreur"],
                            "OK",
                            () {
                              Navigator.of(context).pop();
                            },
                          );
                        }
                      },
                    );

                    // If the form is valid, display a Snackbar.
                  }
                },
                color: const Color(0xff3a57e8),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: const BorderSide(color: Color(0xffffffff), width: 1),
                ),
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                textColor: const Color(0xffffffff),
                height: 50,
                minWidth: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ));
  }
}
