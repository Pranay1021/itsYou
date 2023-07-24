
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew/model/friend.dart';
import 'package:crew/model/member.dart';
import 'package:crew/model/notification.dart';
import 'package:crew/model/question.dart';
import 'package:crew/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseServices {

                          
  final String uid;
  DatabaseServices({required this.uid});
  
  
  //collection reference

  final CollectionReference crewCollection =
      FirebaseFirestore.instance.collection('crewss');
  final CollectionReference friendCollection =
      FirebaseFirestore.instance.collection('friends');
  final CollectionReference questionCollection =FirebaseFirestore.instance.collection('questions');
 
 

  Future updateUserData(String age, String name, int reveals,String bio,String image, String gender , int popularity,int ques) async {
    return await crewCollection
        .doc(uid)
        .set({
          'uid':uid,
          'name': name, 
          'age': age,
          'reveals': reveals,
          'bio': bio,
          'image': image,
          'gender':gender,
          'popularity':popularity,
          'quesAnswered':ques,
          });
  }
  Future increQuesAnswered(int ques) async{
    return await crewCollection
        .doc(uid)
        .update({
          'quesAnswered':ques,
          });
  }
  Future updatePopularity(String otheruser_mem_uid,int popularity) async {
    return await crewCollection
        .doc(otheruser_mem_uid)
        .update({
          'popularity':popularity,
          });
  }
  Future sendNotification(String otheruser_mem_uid,String message,String name,String gender,String image,String tag) async {
    return crewCollection
        .doc(otheruser_mem_uid).collection('notifications')
        .add({
          'sendername':name,
          'message':message,
          "time": DateTime.now().millisecondsSinceEpoch,
          "sender" :  FirebaseAuth.instance.currentUser!.uid,
          "receiver" : otheruser_mem_uid,
          "gender" : gender,
          'senderimage': image ,
          'tag':tag,
          'isopened':false,
          'isRevealed':false,
          });
  }

  Future isRevealedorNot(bool isRevealed,String notiid) async {
    return crewCollection
        .doc(uid).collection('notifications').doc(notiid).update
        ({
          'isRevealed':isRevealed,
          });
  }


  Future isReadorNot(bool isopened,String notiid) async {
    return crewCollection
        .doc(uid).collection('notifications').doc(notiid).update
        ({
          'isopened':isopened,
          });
  }

  Future addFriend(String frienduid){
    return crewCollection
        .doc(uid).collection('friends').doc(frienduid)
        .set({
          'uid':frienduid,
          });
  }
 
  Future removeFriend(String frienduid){
    return crewCollection
        .doc(uid).collection('friends').doc(frienduid)
        .delete();
  }

//memebr list from snapshot all user
List<Member> _memberListFromSnapshot(QuerySnapshot snapshot){
   return snapshot.docs.map((doc){
     return Member(
       name: doc.get('name') ?? '',
       age: doc.get('age') ?? '',
       reveals: doc.get('reveals') ?? 0,
       uid: doc.get('uid') ?? '',
       bio: doc.get('bio') ?? '',
       image: doc.get('image') ?? '',
       gender:  doc.get('gender'),
      popularity: doc.get('popularity') ?? 0,
     );
   }).toList();
  }



//userdata from  snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid: uid,
    name: snapshot.get('name'),
    age: snapshot.get('age'),
    reveals: snapshot.get('reveals'),
    bio: snapshot.get('bio'),
    image: snapshot.get('image'),
    gender: snapshot.get('gender'),
    popularity: snapshot.get('popularity'),
    quesAnswered: snapshot.get('quesAnswered'),
  );
}


//get notification
List<Noti> _notifromSnapshot(QuerySnapshot snapshot){
  return snapshot.docs.map((doc) {
    return Noti(
      notiid: doc.id,
      sendername: doc.get('sendername') ?? '',
      message: doc.get('message') ?? '',
      time: doc.get('time') ?? '',
      receiver: doc.get('receiver') ?? '',
      sender: doc.get('sender'),
      gender: doc.get('gender'),
      image:doc.get('senderimage'),
      tag:doc.get('tag'),
      isopened:doc.get('isopened'),
      isRevealed:doc.get('isRevealed'),
    );
  }).toList();
}

List<Friend> _friendlistfromSnapshot(QuerySnapshot snapshot){
  return snapshot.docs.map((doc) {
    return Friend(
       uid: doc.get('uid') ?? '',
    );
  }).toList();
}

//updateReveals
Future updateReveals(int reveals) async {
    return await crewCollection
        .doc(uid)
        .update({
          'reveals':reveals,
          });
  }

//get ques stream
List<Question> quesfromdoc(QuerySnapshot snapshot){
  return snapshot.docs.map((doc){
     return Question(
      question: doc.get('questions') ?? '',
     );
   }).toList();
} 

Stream<List<Question>> get question_stream{
  return questionCollection.snapshots().map(quesfromdoc);
}

Stream<List<Member>> get crews_stream {
  return crewCollection.snapshots().map(_memberListFromSnapshot);
}


//get user doc stream
Stream <UserData> get user_doc_stream{
  return crewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
}

//get notification stream
Stream <List<Noti>> get noti_stream{
  return crewCollection.doc(uid).collection('notifications').orderBy('time',descending: true).limit(50).snapshots().map(_notifromSnapshot);
}

Stream <List<Friend>> get friend_stream{
  return crewCollection.doc(uid).collection('friends').limit(50).snapshots().map(_friendlistfromSnapshot);
}

}
//storage servies


class StoreData {
    String uid= FirebaseAuth.instance.currentUser!.uid;
    final FirebaseStorage _storage = FirebaseStorage.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<String> uploadImageToStorage(String pic_name,Uint8List file) async {
      Reference ref = _storage.ref().child(pic_name  + uid);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }

    Future<String> saveData({
      required Uint8List file,
    }) async {
      String resp = " Some Error Occurred";
      try{
        
          String imageUrl = await uploadImageToStorage('profileImage', file);
          await _firestore.collection('crewss').doc(uid).update({
            'image': imageUrl,
          });

          resp = 'success';
        }
      
          catch(err){
            resp =err.toString();
          }
          return resp;
    } 
}