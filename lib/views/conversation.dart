import 'package:chat_app/halper/constants.dart';
import 'package:chat_app/services/DatabaseMethods.dart';
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
            ? ListView.builder(
                itemCount: snapShot.data.documents.length,
                itemBuilder: (context, index) {
                  return messageTitle(
                    message: snapShot.data.documents[index].data["message"],
                    isItSentByMe:
                        snapShot.data.documents[index].data["sendBy"] ==
                            Constants.myName,
                  );
                },
              )
            : Container();
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
        title: Text(widget.chatRoomId
            .toString()
            .replaceAll("_", "")
            .replaceAll(Constants.myName, "")),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            chatList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0xff1b4381),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: TextField(
                          controller: tecMessage,
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Message",
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: CircleAvatar(
                          child: Icon(Icons.send),
                          backgroundColor: Color(0xffFDC324),
                        ),
                      ),
                    ),
                  ],
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
