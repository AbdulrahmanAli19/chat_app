import 'package:chat_app/services/auth.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController etUserName = new TextEditingController();
  TextEditingController etPassword = new TextEditingController();
  TextEditingController etEmail = new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmail(email: etEmail.text, password: etPassword.text)
          .then((value) => print(value));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context: context, title: "Sign Up"),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 200,
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(hintText: 'Username'),
                              controller: etUserName,
                              validator: (value) {
                                return value.isEmpty || value.length < 2
                                    ? "Username can\'t be less than 4 characters or empty"
                                    : null;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: 'Email'),
                              controller: etEmail,
                              validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                    ? null
                                    : "Enter correct email";
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: 'Password'),
                              controller: etPassword,
                              obscureText: true,
                              validator: (value) {
                                return value.length < 6
                                    ? "Password characters should bigger than 6 "
                                    : null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            signMeUp();
                          },
                          child: signInButtons(
                              btnColor: Color(0xff1b4381),
                              btnText: "Sign Up",
                              textColor: Colors.white),
                        ),
                        SizedBox(height: 10),
                        signInButtons(
                            btnColor: Color(0xff34A853),
                            btnText: "Sign Up With Google",
                            textColor: Colors.white),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Sign In now!",
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
            ),
    );
  }
}
