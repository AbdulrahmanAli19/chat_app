import 'package:chat_app/halper/authenticate.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/views/search.dart';
import 'package:chat_app/views/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.add,
                color: Color(0xffFDC324),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.exit_to_app,
                color: Color(0xffFDC324),
              ),
            ),
          )

        ],
      ),
      body: Container(
        child: Container(
          height: 148,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                  width: 120,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 120,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/a.jpeg"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        alignment: Alignment.bottomCenter,
                        child: Text("Ahmed"),
                      )
                    ],
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                  width: 120,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 120,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/b.jpg"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        alignment: Alignment.bottomCenter,
                        child: Text("Bin laden"),
                      )
                    ],
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                  width: 120,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 120,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/c.jpg"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        alignment: Alignment.bottomCenter,
                        child: Text("Simsion"),
                      )
                    ],
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                  width: 120,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 120,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/d.jpg"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        alignment: Alignment.bottomCenter,
                        child: Text("Alpert"),
                      )
                    ],
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                  width: 120,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 120,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/e.jpg"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        alignment: Alignment.bottomCenter,
                        child: Text("Lady"),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
