import 'package:crew/screens/authenticate/register.dart';
import 'package:crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
 bool showSignIn=true;
 void toggleView(){
    setState(() {
      showSignIn=!showSignIn;
    });
 }
 Widget build(BuildContext context) {
   
      if(showSignIn){
        return SignIn(toggleView : toggleView);
      }
      else{

      return Register(toggleView: toggleView);
      } 
    
  }
}