import 'package:flutter/material.dart';
import '../../model/member.dart';
import '../alluser/specificuser.dart';

class FriendListTile extends StatefulWidget {

  final Member? member;  

  FriendListTile({this.member});
  @override
  State<FriendListTile> createState() => _FriendListTileState();
}

class _FriendListTileState extends State<FriendListTile> {
  @override
  Widget build(BuildContext context) {
     return Padding(
          padding:EdgeInsets.only(top:8.0),
          child:InkWell(
            child: Container(
              height: 85,
              child: Card( 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.teal[400],
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child:Center(
                  child: ListTile(
                      leading: (widget.member?.image != "" )? CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 25.0,
                          backgroundImage: NetworkImage(widget.member?.image ?? ''),
                        ),
                      ):
                      CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25.0,
                          child:Icon(Icons.person,size:30),
                        ),
                      ),
                      title: Text(widget.member?.name ?? '',style: TextStyle(color: Colors.white),),
                      trailing: Text('Popularity : ${widget.member!.popularity}',style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            onTap: (){
              showModalBottomSheet(context: context,isScrollControlled: true,backgroundColor: Colors.transparent, builder: (context){
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                    ),
                    height: 300,
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                    child: SpecificUser(member: widget.member!,isfriend: true),

                ); 
              });
            },
          ),
        );
  }
}