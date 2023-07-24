import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew/model/friend.dart';
import 'package:crew/model/member.dart';
import 'package:crew/model/notification.dart';
import 'package:crew/model/question.dart';
import 'package:crew/screens/alluser/alluser.dart';
import 'package:crew/screens/home/settings_form.dart';
import 'package:crew/servies/auth.dart';
import 'package:crew/servies/database.dart';
import 'package:crew/shared/count.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew/screens/home/crew_llist.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:crew/screens/profile/profile.dart';
import 'package:crew/screens/notification/notification_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'count_down.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();
  Counter counter = Counter();
   final PersistentTabController _controller =
    PersistentTabController(initialIndex: 2);
    
   bool isAvail=true;
    void initState() {
      checkTime(); 
    }
    void checkTime() async {
      var prefs = await SharedPreferences.getInstance();
      var a =  prefs.getInt('timeRemaining');
        if(a == null || a <=0){
          setState(() {
            isAvail=true;
          });
        }
        else{
          setState(() {
            isAvail=false;
          });
        }
    }

  
  @override
 
  Widget build(BuildContext context) {
                                
  
    return MultiProvider(
      providers: [
          StreamProvider<List<Member>?>.value(value: DatabaseServices(uid:"").crews_stream,initialData: null,),
          StreamProvider<List<Noti>?>.value(value: DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid,).noti_stream,initialData: null,),
          StreamProvider<List<Question>?>.value(value: DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid,).question_stream,initialData: null,),
          StreamProvider<List<Friend>?>.value(value: DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid,).friend_stream,initialData: null,),
      ],
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: PersistentTabView(
        context,
        controller: _controller,
        screens:  _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style1,
        
      ),
    ),  
    );
  }
  List<Widget> _buildScreens() {
    return [
          AllUser(),
          ProfileScreen(),
          isAvail? CrewList(toggleView: checkTime): CountDown(toggleView: checkTime),
          Notification_list(),
        ];
  }
    List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.connect_without_contact_sharp),
        title: ("Users"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary:  Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary:  Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications),
        title: ("Notification"),
        activeColorPrimary:  Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
     
    ];
  }
}