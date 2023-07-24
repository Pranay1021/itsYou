import 'package:crew/model/notification.dart';
import 'package:crew/model/user.dart';
import 'package:crew/servies/database.dart';
import 'package:crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew/screens/notification/noti_tile.dart';


class Notification_list extends StatefulWidget {
  const Notification_list({super.key});

  @override
  State<Notification_list> createState() => _Notification_listState();
}

class _Notification_listState extends State<Notification_list> {
  @override

  Widget build(BuildContext context) {
    
    final Noti_list = Provider.of<List<Noti>?>(context) ?? [];
    final f_user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseServices (uid:f_user?.uid ?? '').user_doc_stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData? userData = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Notifications'),
            backgroundColor: Colors.teal[400],
            actions: [
              Center(child: Text('Reveals: ${userData!.reveals!}  ',style: TextStyle(color: Colors.white, fontSize: 20),)),
            ],
          ),
          body: Container(
            color: Colors.teal[200],
            child: ListView.builder(

            itemCount: Noti_list.length,
            itemBuilder: (context, index){
              
              return NotiTile(noti: Noti_list[index],reveals: userData.reveals,);
              },
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