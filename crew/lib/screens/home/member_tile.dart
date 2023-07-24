import 'package:crew/model/member.dart';
import 'package:crew/model/user.dart';
import 'package:crew/servies/database.dart';
import 'package:crew/shared/count.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberTile extends StatefulWidget {
  final Member? member;  
  final String? message;
  final Function checkTime;
  final Function resetshuffle;
  final Function quesRandom;
  MemberTile({required this.quesRandom,this.member,this.message,required this.checkTime,required this.resetshuffle});

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  @override
  Widget build(BuildContext context) {
     final f_user = Provider.of<MyUser?>(context);
      return StreamBuilder<UserData>(
      stream: DatabaseServices (uid:f_user?.uid ?? '').user_doc_stream,
      builder: (context, snapshot) {
        UserData? userData = snapshot.data;
        return Padding(
          padding:EdgeInsets.fromLTRB(10, 8, 10, 0),
          child:InkWell(
            child: Card( 
              shape: RoundedRectangleBorder(
                 side: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),borderRadius: BorderRadius.circular(20)),
              color: Colors.teal[400],
              child:Center(
                child: ListTile(
                    leading: (widget.member?.image != "" )? CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 23.0,
                        backgroundImage: NetworkImage(widget.member?.image ?? ''),
                      ),
                    ):
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 23.0,
                        child:Icon(Icons.person,size: 30,),
                      ),
                    ),
                    title: Text(widget.member?.name ?? '',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            onTap: () async {
              int memberpopularity = widget.member!.popularity! + 1;
              int ques = userData!.quesAnswered! + 1;
              if(ques % 20== 0){
                DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).updateReveals(userData.reveals! + 1);
              }
               Counter.incrementCounter();             
               DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).updatePopularity(widget.member!.uid!, memberpopularity);
               DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).sendNotification(widget.member!.uid!,widget.message!,userData.name!,userData.gender!,userData.image!,'vote',);
               DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).increQuesAnswered(ques);
              widget.resetshuffle();
              if(Counter.count == 0){
                var prefs = await SharedPreferences.getInstance();
                await prefs.setInt('timeRemaining', 60000);
                await prefs.setInt('timestamp', DateTime.now().millisecondsSinceEpoch);
                widget.checkTime();
              }
              widget.quesRandom();
            },
          ),
        );
      }
    );
  }
}