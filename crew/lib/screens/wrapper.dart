import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crew/screens/authenticate/authenticate.dart';
import 'package:crew/screens/authenticate/verify.dart';
import 'package:crew/screens/home/noInternet.dart';
import 'package:flutter/material.dart';
import 'package:crew/screens/home/home.dart';
import 'package:crew/model/user.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatefulWidget {

  @override
  State<Wrapper> createState() => _WrapperState();
}
  

class _WrapperState extends State<Wrapper> {
  Connectivity connectivity = Connectivity();
  @override
  Widget build(BuildContext context) {
   
    final f_user = Provider.of<MyUser?>(context);
   
    //return either home or authenticate 

    if(f_user==null){
      return StreamBuilder<ConnectivityResult>(
        stream: connectivity.onConnectivityChanged,
        builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
            final state= snapshot.data!;
            if(state == ConnectivityResult.none){
              return NoInternet();
            }
            else{
               return Authenticate();
            }
            }
            else{
              return NoInternet();
            }
        }
      );
    }
    else{
      print(f_user.isEmailVerified);
      if(f_user.isEmailVerified!){
        return StreamBuilder<ConnectivityResult>(
          stream: connectivity.onConnectivityChanged,
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.active){
            final state= snapshot.data!;
            if(state == ConnectivityResult.none){
              return NoInternet();
            }
            else{
               return Home();
            }
            }
            else{
              return NoInternet();
            }
          }
        );
        }
      else{
        return StreamBuilder<ConnectivityResult>(
          stream: connectivity.onConnectivityChanged,
          builder: (context, snapshot) {
           if(snapshot.connectionState==ConnectionState.active){
            final state= snapshot.data!;
            if(state == ConnectivityResult.none){
              return NoInternet();
            }
            else{
              return VerifyPage();
            }
           }
            else{
              return NoInternet();
            }
          }
        );
      }
    }
    

  }
}