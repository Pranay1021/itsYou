import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
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
                  child: Center(child: Text('OOPS!! Looks like you are not connected to the internet. Internet joda na.',textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontSize: 20))),
                ),
                ), 
                Lottie.asset('assets/nonet.json',height: 300,width: 300),   
            ],
          ),
        ),
      );
  }
}