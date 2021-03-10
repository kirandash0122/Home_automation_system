import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseMethods{
  getUserByUsername(String username) async{
    return await FirebaseFirestore.instance.collection("user").where("name",isEqualTo: username).get();
  }
  getUserNameByEmail(String userEmail) async {
    return await FirebaseFirestore.instance.collection("user").where("email",isEqualTo: userEmail).get();
  }
  uploadUserInfo(userMap) async{
    await FirebaseFirestore.instance.collection("user").add(userMap).
    catchError((onError)=>print(onError.toString()));
    //print("useradded to firestore");
  }
  createChatRoom(String chatRoomId,chatRoomMap) async {
    await FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId).set(chatRoomMap).
    catchError((onError)=>print(onError.toString()));
  }

  addConversation(String chatRoomId,messageMap) async{
    await FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId).collection("chats").add(messageMap);
  }
  getConversation(String chatRoomId) {
    return FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId).collection("chats").orderBy("time",descending: false).snapshots();
  }
  getChatRooms(String userName){
    return FirebaseFirestore.instance.collection("ChatRoom").where("users",arrayContains: userName)
        .snapshots();
  }
}