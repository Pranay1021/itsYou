
import 'dart:async';
import 'dart:math';
import 'package:crew/model/friend.dart';
import 'package:crew/model/question.dart';
import 'package:crew/screens/home/member_tile.dart';
import 'package:crew/shared/count.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew/model/member.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrewList extends StatefulWidget {
  final Function toggleView;
  
  const CrewList({required this.toggleView});
  @override
  State<CrewList> createState() => _CrewListState();
}

class _CrewListState extends State<CrewList> {
  
  int shufflecount=0;
  int rand=0;

  @override
  void initState() {
    rand = Random().nextInt(414);
  }


  void reset(){
    shufflecount=0;
  }
  
  void nextQues(){
    rand = Random().nextInt(414);
  }
  @override
    Widget build(BuildContext context) {
        
        final crew_members = Provider.of<List<Member>?>(context) ?? [];
        final friend = Provider.of<List<Friend>?>(context) ?? [];
        final friendlist = crew_members.where((element) => friend.any((element2) => element2.uid == element.uid)).toList();
        friendlist.shuffle();
        String question_now='';
        Future<List<Question>> getques() async{
          final ques = Provider.of<List<Question>?>(context) ?? [];
          return ques;
        }
      return Scaffold(
        backgroundColor: Colors.teal[400],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal[400],
          title: Text('ItsYou ')
        ), 
        body:
          FutureBuilder<List<Question>>(
             future: getques(),
             builder: (context, AsyncSnapshot<List<Question>> snapshot) {
              if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.length >= 414){
                question_now = snapshot.data![rand].question.toString();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20,),
                            Align(
                              alignment: Alignment.center,
                              child: 
                              Text('Who is!!?',style: TextStyle(color: Colors.red[600],fontSize: 40,fontFamily: 'Kablammo',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold))),
                            SizedBox(height: 10,),
                            Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 300,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2,color: Colors.black),
                                shape:BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius:BorderRadius.circular(20),
                              ),
                              child: Center(child: Text('${question_now} ??',textAlign: TextAlign.center, style: TextStyle(
                                color: Colors.black,fontSize: 20
                              )))),
                              
                            //Counter
                            Padding(
                              padding: const EdgeInsets.fromLTRB(22,30,0,0),
                              child: LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width - 50,
                                lineHeight: 20.0,
                                percent: (Counter.count%10)/10,
                                center: Text("${(Counter.count%10).toString()}/10"),
                                barRadius: Radius.circular(20),
                                progressColor: Colors.amber[100],
                          ),
                            ),
                            SizedBox(height: 20,),

                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(00, 20, 00, 0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.teal[200],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60.0),
                                      topRight: Radius.circular(60.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(20,20,20,0 ),
                                      child: GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 1.0,
                                        mainAxisSpacing: 10.0,
                                        childAspectRatio: 2.3,
                                        ),
                                        shrinkWrap: true,
                                        itemCount: 4,
                                        itemBuilder: (context, index){
                                            if(friendlist.length >= 4){
                                          return MemberTile(member:friendlist[index],message: question_now,checkTime: widget.toggleView,resetshuffle: reset,
                                          quesRandom: nextQues
                                          );
                                          
                                            }
                                          else if(friendlist.length < 4 && index < friendlist.length){
                                          return MemberTile(member:friendlist[index],message: question_now,checkTime: widget.toggleView,resetshuffle:reset,
                                          quesRandom: nextQues);
                                          }
                                          else{
                                            return Container(
                                              margin: EdgeInsets.fromLTRB(10, 2, 10, 10),
                                              child: Card( 
                                                  shape: RoundedRectangleBorder(
                                                     side: BorderSide(
                                                        color: Colors.black,
                                                        width: 2,
                                                      ),
                                                    borderRadius: BorderRadius.circular(200.0),
                                                  ),
                                                  color: Colors.teal[400],
                                                  child:Center(
                                                    child: ListTile(
                                                        leading:
                                                        CircleAvatar(
                                                          radius: 25,
                                                          backgroundColor: Colors.black,
                                                          child: CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            radius: 23.0,
                                                            child:Icon(Icons.person,size: 30,),
                                                          ),
                                                        ),
                                                        title: Text( 'Add a friend',style: TextStyle(color: Colors.white),),
                                                    ),
                                                  ),
                                                ),
                                            );
                                          }
                                        },
                                       ),
                                    ),
                                  ),
                                ),
                                
                              ),
                              
                            ),
                            Container(
                              color: Colors.teal[200],
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(68, 0.0, 0, 0),
                                child: Row(
                                  
                                      children: [
                                        TextButton(onPressed: () async {
                                          if(shufflecount == 3){
                                            return;
                                          }
                                          friendlist.shuffle();
                                          setState(() {
                                            shufflecount++;
                                          });
                                        
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
                                      Text('Shuffle ${shufflecount}/3',style: TextStyle(color: Colors.green[900]),)),
                                      Lottie.asset('assets/eggroll.json',height: 100,width: 100),
                                      TextButton(onPressed: () async {

                                          Counter.incrementCounter();   
                                          
                                          setState(() {
                                            nextQues();
                                            shufflecount=0;
                                          });          
                                          if(Counter.count == 0){
                                            var prefs = await SharedPreferences.getInstance();
                                            await prefs.setInt('timeRemaining', 60000);
                                            await prefs.setInt('timestamp', DateTime.now().millisecondsSinceEpoch);
                                            widget.toggleView();
                                          }
                                         
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
                                        Text('Skip',style: TextStyle(color: Colors.green[900]),)),
                                            ],
                                          ),
                              ),
                            ),
                            
                                ],
                              );
                  
                      }
              else{
                  return Loading();
                  }
                }
          
                ),
          );
      
  }
}