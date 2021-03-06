import 'package:chat_app/halper/helperfunction.dart';
import 'package:chat_app/services/DatabaseMethods.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chatrooms.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;

  final formKey1 = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  QuerySnapshot snapshot;

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController etcEmail = new TextEditingController();
  TextEditingController etcPassword = new TextEditingController();

  signMeIn() {
    if (formKey1.currentState.validate()) {
      HelperFunction.setUserEmail(etcEmail.text);

      databaseMethods.getUsersByUserEmail(etcEmail.text).then((val) {
        snapshot = val;
        String name = snapshot.documents[0].data["name"];
        HelperFunction.setUsername(name);
        HelperFunction.setUserLoggedIn(true).then((value) {});
      });
      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmail(
              email: etcEmail.text.trim(), password: etcPassword.text.trim())
          .then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context: context, title: "Sign In"),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 200,
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: Form(
                          key: formKey1,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(hintText: 'Email'),
                                controller: etcEmail,
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Enter correct email";
                                },
                              ),
                              TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Password'),
                                  controller: etcPassword,
                                  obscureText: true,
                                  validator: (val) {
                                    return val.length < 6
                                        ? "Password characters should bigger than 6 "
                                        : null;
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
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
                      ),
                      GestureDetector(
                        onTap: () {
                          try {
                            signMeIn();
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        child: signInButtons(
                            btnColor: Color(0xff1b4381),
                            btnText: "Sign In",
                            textColor: Colors.white),
                      ),
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
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 9.0),
                                child: Text(
                                  "Register now!",
                                  style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
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
