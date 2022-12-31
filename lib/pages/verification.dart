///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../config.dart';
import '../modal/User.dart';
import '../services/auth_service.dart';

class verification extends StatefulWidget {
  const verification({Key? key}) : super(key: key);

  @override
  _verification createState() => _verification();
}

class _verification extends State<verification> {
  var user = User();
  var code = "";
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        user = arguments['user'];

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color(0xff3a57e8),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Text(
                      "Verification",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        Image(
                      image: NetworkImage(
                          "https://cdn3.iconfinder.com/data/icons/infinity-blue-office/48/005_084_email_mail_verification_tick-512.png"),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                " We have send you an access code via GMAIL for email verifications.",
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Text(
              "Enter Code here",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xff545454),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 16, 30, 50),
              child: OtpTextField(
                numberOfFields: 5,
                keyboardType: TextInputType.text,
                showFieldAsBox: true,
                fieldWidth: 50,
                filled: true,
                fillColor: Color(0x00000000),
                enabledBorderColor: Color(0xffaaaaaa),
                focusedBorderColor: Color(0xff3a57e8),
                borderWidth: 2,
                margin: EdgeInsets.all(0),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                obscureText: false,
                borderRadius: BorderRadius.circular(8.0),
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Color(0xff000000),
                ),
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  code = verificationCode;
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xff3a57e8),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  debugPrint("code " + code.toString());
                  debugPrint("code " + user.code.toString());
                  if (user.code != code) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Verification Code"),
                            content: Text('Code entered is incorrect'),
                          );
                        });
                  } else {
                    AuthService.save(user).then(
                      (response) {
                        var c = response as Map<String, dynamic>;
                        var d = c["statusCode"] as int;
                        if (d == 200) {
                          Navigator.of(context).pushNamed('/login');
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(Config.appName),
                                  content: Text(c["fiels"] + " " + c["erreur"]),
                                );
                              });
                        }
                      },
                    );
                  }
                },
                icon: Icon(Icons.arrow_forward,
                    color: Color(0xffffffff), size: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                "Resend Code",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color(0xff3a57e8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
