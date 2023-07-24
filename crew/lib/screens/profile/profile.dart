
import 'package:crew/model/friend.dart';
import 'package:crew/model/member.dart';
import 'package:crew/screens/alluser/alluser.dart';
import 'package:crew/screens/profile/friendlisttile.dart';
import 'package:crew/servies/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:crew/model/user.dart';
import 'package:crew/servies/database.dart';
import 'package:crew/shared/loading.dart';
import 'package:crew/screens/home/settings_form.dart';
import 'package:crew/screens/profile/profile_controller.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
     final f_user = Provider.of<MyUser?>(context);
    
     void _showSettingsPanel(BuildContext context){
      showModalBottomSheet(context: context,isScrollControlled: true,backgroundColor: Colors.transparent, builder: (context){
       return Container(
        height: 340,
        decoration: BoxDecoration(
          color: Colors.teal[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          )
        ),
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        child: Settings_Form(),
        
       ); 
      });
    }

     void _showFriendList(BuildContext context){
      showModalBottomSheet(context: context,isScrollControlled: true,backgroundColor: Colors.transparent, builder: (context){
         
    
           return StreamBuilder<List<Friend>>(
             stream:  DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).friend_stream,
             builder: (context, snapshot) {
              final crew_members = Provider.of<List<Member>?>(context) ?? [];
              final friend = Provider.of<List<Friend>?>(context) ?? [];
              final friendlist = crew_members.where((element) => friend.any((element2) => element2.uid == element.uid)).toList();
                if(!snapshot.hasData){
                  return Loading();
                }
               return Container(
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )
                ),
                padding: EdgeInsets.fromLTRB(10,35,10,0),
                child: Column(
                  children: [
                    
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                          child: Text('Friends : ${friendlist.length}',style: TextStyle(color: Colors.green[900],fontSize: 20,
                                    ),),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: (){
                            showSearch(context: context, delegate: Search(list: friendlist));
                          },
                          icon: Icon(Icons.search),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: friendlist.length,
                          itemBuilder: (context, index){
                            return FriendListTile(member: friendlist[index]);
                          },
                        ),
                    ),
                  ],
                ),
                
               );
             }
           );
         
        
      });
    }
   
    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid:f_user?.uid ?? '').user_doc_stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
              UserData? userData = snapshot.data;
        return Scaffold(
            backgroundColor: Colors.teal[400],
            appBar: AppBar(
              backgroundColor: Colors.teal[400],
              elevation: 0.0,
              title: Text('Profile'),
              actions: [
                TextButton.icon(
                  onPressed: () async {
                  print('you logged out');
                  await _auth.signingOut();
                  },
            icon: Icon(Icons.person,
            color: Colors.white,),
            label: Text('logout',
            style: TextStyle(color: Colors.white),),
           ),
              ],
            ),
            body: ChangeNotifierProvider(
              create: (_) => ProfileController(),
              child: Consumer<ProfileController>(
                builder:(context,provider,child){
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                          Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,4,0,0),
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black, width: 3),
                                  color: Colors.white,
                              ),
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child:  (provider.image == null) ? userData!.image == "" ? Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.lightBlue,
                                  ) :
                                Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(userData.image!),
                                  loadingBuilder: (context,child,loadingProgress){
                                    if(loadingProgress == null)return child;
                                    return Center(child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ));
                                  },
                                  errorBuilder: (context,error,stackTrace){
                                    return Center(child: Text('Error'));
                                  },
                                  ) 
                                  :
                               CircleAvatar(
                                 radius: 100,
                                 backgroundImage: MemoryImage(provider.imageBytes!),
                               ),
                              ),
                            ),
                          ),
                        ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(95, 0, 0, 0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 19,
                        child: IconButton(
                          onPressed: (){
                            if(context != null ){
                              provider.pickImage(context);
                            }
                          },
                          icon: Icon(Icons.camera_alt,color: Colors.black,),
                        ),
                      ),
                    ),
                    
                    ],
                    ),
                    SizedBox(height: 20,),
                     Center(child: Text('@${userData!.name}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                    SizedBox(height: 20,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('${userData.bio}',
                        style:TextStyle(color: Colors.white,fontSize: 16)),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,20),
                      child: Center(
                        child: Column(
                          children: [
                            CircularPercentIndicator(
                                       radius: 30.0,
                                        percent: (userData.quesAnswered!%20)/20,
                                        center: Text("${(userData.quesAnswered!%20).toString()}/20"),
                                        progressColor: Colors.amber[100],
                                  ),
                                  Text('(Reveals +1) '),
                          ],
                        ),
                              
                      ),
                    ),
                    
                  Container(
                    height: 200,
                  decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                   ),
                    color: Colors.teal[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50.0,30,20,0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        //username and age
                        Text('Date of Birth : ${userData.age}', 
                        style: TextStyle(color: Colors.green[900],fontSize: 20,
                        ),),
                        SizedBox(height: 20),
                        //popularity
                        Text('Popularity : ${userData.popularity}', style: TextStyle(
                          
                          color: Colors.green[900],fontSize: 20),),
                        SizedBox(height: 20),
                        //bio
                        Row(
                          children: [
                            TextButton(onPressed: () async {

                                 _showFriendList(context);
                            },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.green[900]!),
                                  )
                                )
                              ),
                             child: 
                            Text('Friends',style: TextStyle(color: Colors.green[900]),)),
                       
                            Spacer(),
                            TextButton(onPressed: () async {

                             _showSettingsPanel(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.green[900]!),
                              )
                            )
                          ),
                         child: 
                        Text('Edit Profile',style: TextStyle(color: Colors.green[900]),)),
                        SizedBox(width: 20)
                          ],
                        ),

                        //button
                        
                      ],
                    ),
                  ),
                  ),
                 ],
                ),
            );
                }
              ),
            )
        );
      }
      else{
        return Loading();
      }
      }
    );

  }
}