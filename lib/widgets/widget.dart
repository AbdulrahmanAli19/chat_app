import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBarMain({BuildContext context, String title}) {
  return AppBar(
    title: Text(title),
  );
}

TextField textFieldInputDecorationDM({String hintText, bool obscureText}) {
  //DarkMode textField
  return TextField(
    obscureText: obscureText,
    style: TextStyle(),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffFDC324),
        ),
      ),
    ),
  );
}

Container signInButtons({String btnText, Color textColor,Color btnColor}){
  return Container(
    child: Text(
      btnText,
      style: TextStyle(color: textColor, fontSize: 17),
    ),
    alignment: Alignment.center,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: btnColor,
    ),
  );
}