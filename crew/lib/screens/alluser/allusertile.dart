
import 'package:crew/screens/alluser/specificuser.dart';
import 'package:flutter/material.dart';
import 'package:crew/model/member.dart';



class AllUserTile extends StatefulWidget {
  final Member? member;  
  final bool? isfriend;
  final int? rank;
  AllUserTile({this.isfriend,this.member,this.rank});
  
  @override
  State<AllUserTile> createState() => _AllUserTileState();
}

class _AllUserTileState extends State<AllUserTile> {
  
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
                      leading: 
                       Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (widget.rank == 1) ? Icon(Icons.emoji_events,color: Colors.yellow[700],size: 30,): SizedBox(),
                          (widget.rank == 2) ? Icon(Icons.emoji_events,color: Colors.grey,size: 30,) : SizedBox(),
                          (widget.rank == 3) ? Icon(Icons.emoji_events,color: Colors.orange[700],size: 30,) : SizedBox(),
                          (widget.rank! > 3) ? Text('${widget.rank} ',style: TextStyle(color: Colors.white,fontSize: 20),) : SizedBox(),
                          (widget.member?.image != "" )?
                          CircleAvatar(
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
                        ]
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
                    child: SpecificUser(member: widget.member,isfriend: widget.isfriend,),
                ); 
              });
            },
          ),
        );
    
  }
}