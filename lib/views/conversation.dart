import 'package:chat_app/halper/constants.dart';
import 'package:chat_app/services/DatabaseMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyConversation extends StatefulWidget {
  final String chatRoomId;

  MyConversation({this.chatRoomId});

  @override
  _MyConversationState createState() => _MyConversationState();
}

class _MyConversationState extends State<MyConversation> {
  TextEditingController tecMessage = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream conversationStream;

  @override
  void initState() {
    databaseMethods
        .getConversationMessages(chatRoomId: widget.chatRoomId)
        .then((value) {
      print(value);
      setState(() {
        conversationStream = value;
      });
    });
    super.initState();
  }

  Widget chatList() {
    return StreamBuilder(
      stream: conversationStream,
      builder: (context, snapShot) {
        return snapShot.hasData
            ? Expanded(
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapShot.data.documents.length,
                  itemBuilder: (context, index) {
                    return messageTitle(
                      message: snapShot.data.documents[index].data["message"],
                      isItSentByMe:
                          snapShot.data.documents[index].data["sendBy"] ==
                              Constants.myName,
                    );
                  },
                ),
              )
            : Container(
                child: Center(
                  child: Text("Start conversation"),
                ),
              );
      },
    );
  }

  sendMessage() {
    if (tecMessage.text.isNotEmpty) {
      Map<String, dynamic> conversationMap = {
        "message": tecMessage.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(
          chatRoomId: widget.chatRoomId, messageMap: conversationMap);
      tecMessage.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(widget.chatRoomId
                  .toString()
                  .replaceAll("_", "")
                  .replaceAll(Constants.myName, "")),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.centerLeft,
              child: Text(
                "online",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: chatList(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                child: Container(
                  margin: EdgeInsets.fromLTRB(3, 2, 3, 2),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xffFDC324),
                        Color(0xffe0aa21),
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          child: TextField(
                            controller: tecMessage,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: TextStyle(),
                              filled: true,
                              hintText: "Message",
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          sendMessage();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Icon(
                            Icons.send,
                            color: Color(0xff6a96d8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class messageTitle extends StatelessWidget {
  final String message;
  final bool isItSentByMe;

  messageTitle({this.message, this.isItSentByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isItSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isItSentByMe ? Color(0xffFDC324) : Colors.grey.shade200,
          borderRadius: isItSentByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Text(
          message,
          style: TextStyle(),
        ),
      ),
    );
  }
}
