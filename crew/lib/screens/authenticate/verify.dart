import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatefulWidget {
  @override
  State<VerifyPage> createState() => _VerifyPageState();
}



class _VerifyPageState extends State<VerifyPage> {

  late bool _isEmailVerified ;
  bool canresendemail=false;
  Timer ?timer;
  Timer ?cansendTimer;
  int timeCooldown=120;
 
  void initState() {

    super.initState();

    _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    print(_isEmailVerified);
    if(_isEmailVerified == false){
      sendVerificationEmail();
      timer = 
      Timer.periodic(Duration(seconds:2),
       (_) => checkEmailVerified());
    }
    cansendTimer = Timer.periodic(Duration(seconds:1),
       (timer) {
          if(timeCooldown>0){
            setState(() {
              timeCooldown--;
            });
          }
          else{
            setState(() {
              canresendemail=true;
            });
          }
        });
   
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    print(_isEmailVerified);
    setState(() {
      _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(_isEmailVerified){
      Navigator.of(context).pushReplacementNamed('/home');
      timer!.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    cansendTimer!.cancel();
    super.dispose();
  }

  Future sendVerificationEmail () async {
    try{
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    }
    catch(e){
      print("An error occured while trying to send email verification");
    }
  }
  @override
  Widget build(BuildContext context) {
       return Scaffold(
      backgroundColor: Colors.teal[400],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Card(
                color: Colors.teal[100],
                shape: RoundedRectangleBorder( //<-- 1. SEE HERE
                  side: BorderSide(
                    color: Color.fromARGB(255, 38, 166, 154),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: 200,
                  width: 300,
                  padding: EdgeInsets.all(16),
                  child: Center(child: Text('An email has been sent to ${FirebaseAuth.instance.currentUser!.email} please verify',textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontSize: 20))),
                ),
                ),    
                (canresendemail) ? 
                TextButton(onPressed: () async {
                        sendVerificationEmail();
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
                Text('Resend Email',style: TextStyle(color: Colors.green[900]),))
                  :
                Text("Resend Email in $timeCooldown seconds",),
                SizedBox(height: 20,),
                TextButton(onPressed: () async {
                        FirebaseAuth.instance.signOut();
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
                Text('Cancel',style: TextStyle(color: Colors.green[900]),))
            ],
          ),
        ),
      );
  }
  
  
}