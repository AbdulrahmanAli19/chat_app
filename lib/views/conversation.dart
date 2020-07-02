import 'package:chat_app/halper/constants.dart';
import 'package:flutter/material.dart';

class MyConversation extends StatefulWidget {
  @override
  _MyConversationState createState() => _MyConversationState();
}

class _MyConversationState extends State<MyConversation> {
  @override
  void initState() {
    print(Constants.myName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.otherUSer),
      ),
    );
  }
}
