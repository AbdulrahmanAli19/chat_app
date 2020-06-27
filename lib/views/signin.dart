import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context: context, title: "Sign In"),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 200,
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(decoration: InputDecoration(hintText: 'Email')),
                TextField(
                  decoration: InputDecoration(hintText: 'Password'),
                  obscureText: true,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  alignment: Alignment.centerRight,
                  child: Container(
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 10.0)),
                ),
                signInButtons(
                    btnColor: Color(0xff1b4381),
                    btnText: "Sign In",
                    textColor: Colors.white),
                SizedBox(height: 10),
                signInButtons(
                    btnColor: Color(0xff34A853),
                    btnText: "Sign In With Google",
                    textColor: Colors.white),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Don\'t have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Register now!",
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(height: 70),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
