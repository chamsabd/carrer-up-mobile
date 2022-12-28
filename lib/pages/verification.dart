///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0x00ffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Verification",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: NetworkImage(
                      "https://cdn4.iconfinder.com/data/icons/avatar-users/512/Avatar_Users2_15-128.png"),
                  height: 120,
                  width: 120,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  child: Text(
                    "Enter the verification code we just send you on your email address.",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "If you didn't receive a code!",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          color: Color(0xff000000),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Text(
                          "Resend",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
