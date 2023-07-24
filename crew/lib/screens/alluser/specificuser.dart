import 'package:crew/model/user.dart';
import 'package:crew/servies/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/member.dart';

class SpecificUser extends StatefulWidget {
   
    final Member? member;  
    final bool? isfriend;
    SpecificUser({this.member,this.isfriend});
  @override
  State<SpecificUser> createState() => _SpecificUserState();
}

class _SpecificUserState extends State<SpecificUser> {
  @override
  
  
  Widget build(BuildContext context) {
    final f_user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseServices (uid:f_user?.uid ?? '').user_doc_stream,
      builder: (context, snapshot) {
        UserData? userData = snapshot.data;
        return Scaffold(
           backgroundColor: Colors.teal[100],
            body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                         child: (widget.member!.image!= "" ) ? CircleAvatar(
                                 radius: 50,
                                 backgroundColor: Colors.white,
                                 child: CircleAvatar(
                                   backgroundColor: Colors.black,
                                   radius: 45.0,
                                   backgroundImage: NetworkImage(widget.member!.image ?? ''),
                                 ),
                               ):
                  
                           CircleAvatar(
                             radius: 50,
                             backgroundColor: Colors.black,
                             child: CircleAvatar(
                               backgroundColor: Colors.white,
                               radius: 45.0,
                               child:Icon(Icons.person,size: 50,),
                             ),
                           ),
                           ),
    
                           Expanded(
                             child: Padding(
                               padding: const EdgeInsets.only(left: 18),
                               child: Center(child: Text(widget.member!.bio!,style: TextStyle(color: Colors.black,fontSize: 16,),)),
                             ),
                           )
                     ],
                   ),
                    
                    Container(
                      margin: EdgeInsets.fromLTRB(00, 30, 0, 0),
                      child: Text('@${widget.member!.name!}' ,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),

                    Padding(
                      padding: const EdgeInsets.only(top:18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10,20,0,0),
                              child: Text( 'Date of Birth: ${widget.member!.age!} \nPopularity: \t${widget.member!.popularity!} \n\n' ,style: TextStyle(color: Colors.black,fontSize: 16),),
                            ),
                            
                          ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,20,15),
                              child: (widget.isfriend!)?
                              TextButton(
                                style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.green[900]!),
                                        )
                                      )
                                    ),
                                  child: Text('Remove',style: TextStyle(color: Colors.green[900])),
                                  onPressed: () async {
                                    await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).removeFriend(widget.member!.uid!);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Removed from friend list')));
                                    Navigator.pop(context);
                                  },
                                      ):
                              TextButton(
                                style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.green[900]!),
                                        )
                                      )
                                    ),
                                onPressed: () async {
                                    await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).addFriend(widget.member!.uid!);
                                    await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).sendNotification(widget.member!.uid!,'Added you as a friend',userData!.name!,userData.gender!,userData.image!,'friend');
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to friend list')));
                                  },
                                  child: Text('Add',style: TextStyle(color: Colors.green[900]),)
                                  ),
                            ),
                        ],
                      ),
                    ),
                  
                    
                ],
              ),
            
        );
      }
    );
  }
}