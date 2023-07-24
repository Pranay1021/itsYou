import 'package:crew/model/notification.dart';
import 'package:crew/model/user.dart';
import 'package:crew/screens/notification/reveals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crew/model/time.dart';
import 'package:provider/provider.dart';

import '../../servies/database.dart';

class NotiTile extends StatelessWidget {
  final Noti? noti;  
  var date;
  final int? reveals;
  NotiTile({this.noti,this.reveals});
  @override
  Widget build(BuildContext context) {
    int readornot = (noti!.isopened!) ? 200:255;

      showNotiSender(BuildContext context){
      showModalBottomSheet(context: context,backgroundColor: Colors.transparent, builder: (context){
       return Container(
        decoration: BoxDecoration(
          color: Colors.teal[400],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
        ),
         padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
        child: Reveals(reveals: reveals!, message: noti!.message!, sender: noti!.sendername!, image: noti!.image!,showWhoSent: noti!.isRevealed!, notiid: noti!.notiid!, ),
          ); 
          });
        }
    date = DateTime.fromMillisecondsSinceEpoch(noti!.time!);
    
        return (noti!.tag == 'vote') ? Padding(
          padding:EdgeInsets.fromLTRB(2.0,3.0,2.0,0.0),
          child:InkWell(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: (noti!.gender! == 'male') ? Color.fromARGB(readornot, 101, 172, 231): Color.fromARGB(readornot, 238, 154, 183),
              child:ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25.0,
                    child:Icon(Icons.person,size: 30,),
                  ),
                  title: (noti!.gender! == 'male') ? RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    children:[ TextSpan(
                      text:'A guy voted you as ' ,
                      style: TextStyle(
                        color: Colors.black
                      )
                    ),
                    TextSpan(text: 
                    noti!.message,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black
                    ),
                    ),
                    ]
                    )
                    )
                    :
                    RichText(
                    text: TextSpan(
                    children:[ TextSpan(
                      text:'A girl voted you as ' 
                    ),
                    TextSpan(text: 
                    noti!.message,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                    ),
                    ]
                    )
                    ),
                  subtitle: Text(TimeChange().readTimestamp(noti!.time!),style: TextStyle(color: Colors.black)),
              ),
            ),
             onTap: (){
               DatabaseServices(uid:FirebaseAuth.instance.currentUser!.uid).isReadorNot(true,noti!.notiid!);
               showNotiSender(context);
            },
          ),
        ):
        Padding(
          padding:EdgeInsets.fromLTRB(2.0,3.0,2.0,0.0),
          child:Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color:  Colors.teal[100],
            child:ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25.0,
                  child:Icon(Icons.person,size: 30,),
                ),
                title:Text('${noti!.sendername} ${noti!.message} ' ),
                subtitle: Text(TimeChange().readTimestamp(noti!.time!),style: TextStyle(color: Colors.black)),
            ),
          ),
        );

        }
      }