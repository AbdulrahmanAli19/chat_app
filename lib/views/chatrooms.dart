import 'package:chat_app/halper/authenticate.dart';
import 'package:chat_app/halper/constants.dart';
import 'package:chat_app/halper/helperfunction.dart';
import 'package:chat_app/services/DatabaseMethods.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/views/conversation.dart';
import 'package:chat_app/views/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;

  @override
  void initState() {
    getUserInfo();
    print(Constants.myName);
    super.initState();
  }

  Widget createChatContacts() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                      snapshot.data.documents[index].data["chatroomid"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data.documents[index].data["chatroomid"]);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              )
            : Center(
                child: Text("Your chat list is empty"),
              );
      },
    );
  }

  getUserInfo() async {
    HelperFunction.getUsername().then((value) => Constants.myName = value);
    databaseMethods.getChatRooms(userName: Constants.myName).then((val) {
      setState(() {
        chatRoomStream = val;
      });
      print(
          "we got the data + ${val.toString()} this is name  ${Constants.myName}");
    });
    setState(() {});
  }

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
      body: Column(
        children: <Widget>[
          Container(
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
                            height: 85,
                            width: 90,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/a.jpeg"),
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
                            height: 85,
                            width: 90,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/b.jpg"),
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
                            height: 85,
                            width: 90,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/c.jpg"),
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
                            height: 85,
                            width: 90,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/d.jpg"),
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
                            height: 85,
                            width: 90,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/e.jpg"),
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
          Expanded(child: createChatContacts()),
        ],
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String username;
  final String chatRoom;

  ChatRoomsTile(this.username, this.chatRoom);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyConversation(
                      chatRoomId: chatRoom,
                    )));
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Container(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  //TODO: set member image
                  backgroundImage: AssetImage("assets/images/a.jpeg"),
                ),
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Text(
                username,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
