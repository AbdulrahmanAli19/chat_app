import 'package:chat_app/services/DatabaseMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController etcSearch = new TextEditingController();
  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods.getUsersByUserName(etcSearch.text.trim()).then((val) {
      setState(() {
        searchSnapshot = val;
        print(etcSearch.text + " $val, ${val.documents[0].data["name"]}");
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTitle(
                username: searchSnapshot.documents[index].data["name"],
                email: searchSnapshot.documents[index].data["email"],
              );
            },
          )
        : Container(
            child: Text("null"),
          );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    controller: etcSearch,
                    decoration: InputDecoration(hintText: "User Name"),
                  ),
                ),
              ),
              GestureDetector(
                onTap: initiateSearch,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: CircleAvatar(child: Icon(Icons.search)),
                ),
              ),
            ],
          ),
          Expanded(child: searchList()),
        ],
      ),
    );
  }
}

class SearchTitle extends StatelessWidget {
  final String username, email;

  SearchTitle({this.username, this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff1b4381),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  username,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 4,),
              Container(
                child: Text(
                  email,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text("Message"),
              decoration: BoxDecoration(
                  color: Color(0xffFDC324),
                  borderRadius: BorderRadius.circular(30)),
            ),
          )
        ],
      ),
    );
  }
}
