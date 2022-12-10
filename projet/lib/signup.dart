///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';


class signup extends StatelessWidget {

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Color(0xffeff3f8),
body:SizedBox(
height:MediaQuery.of(context).size.height,
width:MediaQuery.of(context).size.width,
child:
Stack(
alignment:Alignment.topCenter,
children: [
Padding(
padding:EdgeInsets.fromLTRB(16, 30, 16, 16),
child:Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:EdgeInsets.fromLTRB(0, 0, 16, 0),
child:Icon(
Icons.arrow_back,
color:Color(0xff150202),
size:24,
),
),
Expanded(
flex: 1,
child: Text(
"Back",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:20,
color:Color(0xff080101),
),
),
),
Text(
"Sign Up",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:20,
color:Color(0xff0a0000),
),
),
],),),
Container(
margin:EdgeInsets.fromLTRB(0, 100, 0, 50),
padding:EdgeInsets.all(0),
height:MediaQuery.of(context).size.height,
decoration: BoxDecoration(
color:Color(0xffffffff),
shape:BoxShape.rectangle,
borderRadius:BorderRadius.circular(32.0),
),
child:
Padding(
padding:EdgeInsets.fromLTRB(16, 60, 16, 16),
child:SingleChildScrollView(
child:
Column(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.start,
mainAxisSize:MainAxisSize.max,
children: [
TextField(
controller:TextEditingController(text:"john"),
obscureText:false,
textAlign:TextAlign.start,
maxLines:1,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
decoration:InputDecoration(
disabledBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
focusedBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
enabledBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
labelText:"User Name",
labelStyle:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xff000000),
),
hintText:"Enter Text",
hintStyle:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
filled:true,
fillColor:Color(0xffffffff),
isDense:false,
contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
prefixIcon:Icon(Icons.person,color:Color(0xff000000),size:24),
),
),
Padding(
padding:EdgeInsets.fromLTRB(0, 16, 0, 0),
child:TextField(
controller:TextEditingController(text:"john@gmail.com"),
obscureText:false,
textAlign:TextAlign.start,
maxLines:1,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
decoration:InputDecoration(
disabledBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
focusedBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
enabledBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
labelText:"Email",
labelStyle:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xff000000),
),
hintText:"Enter Text",
hintStyle:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
filled:true,
fillColor:Color(0xffffffff),
isDense:true,
contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
prefixIcon:Icon(Icons.mail,color:Color(0xff212435),size:24),
),
),
),
Padding(
padding:EdgeInsets.fromLTRB(0, 16, 0, 0),
child:TextField(
controller:TextEditingController(text:"12345678"),
obscureText:true,
textAlign:TextAlign.start,
maxLines:1,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
decoration:InputDecoration(
disabledBorder:InputBorder.none,
focusedBorder:InputBorder.none,
enabledBorder:InputBorder.none,
labelText:"Password",
labelStyle:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xff000000),
),
hintText:"Enter Text",
hintStyle:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
filled:true,
fillColor:Color(0xffffffff),
isDense:true,
contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
suffixIcon:Icon(Icons.visibility_off,color:Color(0xff212435),size:24),
),
),
),
Padding(
padding:EdgeInsets.fromLTRB(0, 30, 0, 0),
child:MaterialButton(
onPressed:(){},
color:Color(0xff3a57e8),
elevation:0,
shape:RoundedRectangleBorder(
borderRadius:BorderRadius.circular(15.0),
side:BorderSide(color:Color(0xffffffff),width:1),
),
padding:EdgeInsets.all(16),
child:Text("SIGN UP", style: TextStyle( fontSize:16,
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
),),
textColor:Color(0xffffffff),
height:50,
minWidth:MediaQuery.of(context).size.width,
),
),
Padding(
padding:EdgeInsets.fromLTRB(0, 30, 0, 0),
child:Row(
mainAxisAlignment:MainAxisAlignment.center,
crossAxisAlignment:CrossAxisAlignment.start,
mainAxisSize:MainAxisSize.max,
children:[

Text(
"Already have an account?",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
Padding(
padding:EdgeInsets.fromLTRB(8, 0, 0, 0),
child:Text(
"Login",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff3a57e8),
),
),
),
],),),
],),),),
),
],),),
)
;}
}