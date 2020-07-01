import 'package:chat_app/halper/authenticate.dart';
import 'package:chat_app/halper/helperfunction.dart';
import 'package:chat_app/views/chatrooms.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    getLoaggedInState();
    super.initState();
  }

  bool isUserLoggedIn ;

  getLoaggedInState() async {
    await HelperFunction.getUserLoggedIn().then((value) {
      setState(() {
        isUserLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //scaffoldBackgroundColor: Color(0xff1b4381),
        primaryColor: Color(0xff1B4381),
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isUserLoggedIn != null ? /**/ isUserLoggedIn ? ChatRoom() : Authenticate() /**/ : Authenticate(),
    );
  }
}
class IamBlank extends StatefulWidget {
  @override
  _IamBlankState createState() => _IamBlankState();
}

class _IamBlankState extends State<IamBlank> {
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}

