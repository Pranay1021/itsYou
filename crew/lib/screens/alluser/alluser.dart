import 'package:crew/model/friend.dart';
import 'package:crew/screens/alluser/allusertile.dart';
import 'package:crew/servies/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew/model/member.dart';

class AllUser extends StatefulWidget {
  const AllUser({super.key});

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  @override
  Widget build(BuildContext context) {
    
    
    return StreamBuilder<List<Friend>>(
      stream: DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).friend_stream,
      builder: (context, snapshot) {
        final crew_members = Provider.of<List<Member>?>(context) ?? [];
        List<Member> search_list = List.from(crew_members);
        search_list.removeWhere((element) => element.uid == FirebaseAuth.instance.currentUser!.uid);
        crew_members.sort((a,b) => b.popularity!.compareTo(a.popularity!));
        print(snapshot.data);
        return Scaffold(
              //search button
              backgroundColor: Colors.teal[100],
              appBar: AppBar(
                backgroundColor: Colors.teal[400],
                elevation: 0,
                title: Text('Users'),
                actions: [
                  IconButton(
                    onPressed: (){
                      showSearch(context: context, delegate: Search(list: search_list));
                    },
                    icon: Icon(Icons.search),
                  )
                ],
              ), 
              body: ListView.builder(
                    shrinkWrap: true,
                    itemCount: crew_members.length >=50 ? 50 : crew_members.length,
                    itemBuilder: (context, index){
                      int position = index+1;
                      bool isfriend = false;
                      if(crew_members[index].uid == FirebaseAuth.instance.currentUser!.uid){
                        return Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Container(
                            height: 85,
                            child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    color: Colors.teal[700],
                                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child:Center(
                                      child: ListTile(
                                          leading:  Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              (position == 1) ? Icon(Icons.emoji_events,color: Colors.yellow[700],size: 30,): SizedBox(),
                                              (position == 2) ? Icon(Icons.emoji_events,color: Colors.grey,size: 30,) : SizedBox(),
                                              (position == 3) ? Icon(Icons.emoji_events,color: Colors.orange[700],size: 30,) : SizedBox(),
                                              (position > 3) ? Text('${position} ',style: TextStyle(color: Colors.white,fontSize: 20),) : SizedBox(),
                                              (crew_members[index].image != "" )?
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  radius: 25.0,
                                                  backgroundImage: NetworkImage(crew_members[index].image ?? ''),
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
                                          ),]
                                          ),
                                          title: Text(crew_members[index].name ?? '',style: TextStyle(color: Colors.white),),
                                          trailing: Text('Popularity : ${crew_members[index].popularity}',style: TextStyle(color: Colors.white)),
                                      ),
                                          ),),
                          ),
                        );
                      }
                      final friend_list = Provider.of<List<Friend>?>(context) ?? [];
                          if(friend_list.length > 0){
                            for(int i=0;i<friend_list.length;i++){
                              if(friend_list[i].uid == crew_members[index].uid){
                                isfriend = true;
                                break;
                              }
                            }
                          }
                      return AllUserTile(member:crew_members[index],isfriend: isfriend, rank: position);
                    },
                        ),
                  );
      }
    );
      
  }
}

class Search extends SearchDelegate {
  List<Member> list= [];
  Search({required this.list});
  @override
  ThemeData appBarTheme(BuildContext context) {
   return ThemeData(
   appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(178, 223, 219, 1), // affects AppBar's background color
   ),
  );   
}
  List<Widget>? buildActions(BuildContext context) {
   return[ 
    IconButton(
      onPressed: (){
        if(query.isEmpty){
          close(context, null);
        }
        else{
        query = '';
        }
      },
      icon: Icon(Icons.clear),
   )
   ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );

    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    var result = list.where((element) => element.name!.contains(query));
    if(result.isEmpty){
     return Container(
      color: Colors.teal[100],
       child: Center(
         child: Text('No results found'),
       ),
     );
     }
     else{
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index){
        return AllUserTile(
          member: result.elementAt(index),
        );
      },
    );
    }
    
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    // TODO: implement buildSuggestions
   var result = list.where((element) => element.name!.contains(query)) ;
   
   if(result.isEmpty){
     return Center(
       child: Text('No results found'),
     );
     }

    else{
    return Container(
      color: Colors.teal[100],
      child: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index){
          bool isfriend = false;
          final friend_list = Provider.of<List<Friend>?>(context) ?? [];
              if(friend_list.length > 0){
                for(int i=0;i<friend_list.length;i++){
                  if(friend_list[i].uid == result.elementAt(index).uid){
                    isfriend = true;
                    break;
                  }
                }
              }
          return AllUserTile(
            member: result.elementAt(index),
            isfriend: isfriend,
            rank: index+1,
          );
        },
      ),
    );
    throw UnimplementedError();
    }
  }
}