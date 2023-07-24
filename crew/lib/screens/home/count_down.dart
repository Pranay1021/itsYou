
import 'package:flutter/material.dart';
import 'package:crew/shared/count.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
class CountDown extends StatefulWidget {
  @override
  final Function toggleView;
  const CountDown({required this.toggleView});
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  @override
  void initState() {
    super.initState();
    _startcountdown();
  }
  int displaytime=60;
  void _startcountdown() async{
    var prefs = await SharedPreferences.getInstance();
    var present_timestamp = DateTime.now().millisecondsSinceEpoch;
    var past_timestamp = prefs.getInt('timestamp') as int;
    int timeleft =  prefs.getInt('timeRemaining') as int;
    Timer.periodic(Duration(seconds: 1), (timer) async{
      displaytime = 60 - ((present_timestamp - past_timestamp)~/1000) ;
      print(displaytime);
      if((present_timestamp - past_timestamp ) >= timeleft){
        Counter.saveTimeRem(0);
        timer.cancel();
        widget.toggleView();
      }
      else{
        setState(() {
          present_timestamp+=1000;
        });
      }
    });
  }


  Widget build(BuildContext context) {
     
    return  Scaffold(
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
                  child: Center(child: Text('OOPS!! Looks like you have used up all the Questions...\nWait  ${displaytime} seconds to get more questions',textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontSize: 20))),
                ),
                ),    
                Lottie.asset('assets/time.json',height: 300,width: 300),
              
            ],
          ),
        ),
      );
  }
}
