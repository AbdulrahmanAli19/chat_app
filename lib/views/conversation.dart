import 'package:flutter/material.dart';

class MyConversation extends StatefulWidget {
  @override
  _MyConversationState createState() => _MyConversationState();
}

class _MyConversationState extends State<MyConversation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("username"),
      ),
    );
  }
}
