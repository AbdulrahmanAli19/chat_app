import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap).catchError((e) {
      print("Uploading error " + e.toString());
    });
  }

  getUsersByUserName(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUsersByUserEmail(String userEmail) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance.collection("chatRoom").document(chatRoomId).setData(
        chatRoomMap).catchError((error) {
      print("chatRoom error: ${error.toString()}");
    });
  }
}
