import 'package:crew/servies/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Reveals extends StatefulWidget {
  int reveals;
  String message;
  String sender;
  String image;
  bool showWhoSent;
  String notiid;
  Reveals({required this.notiid,required this.reveals, required this.message,required this.sender,required this.image,required this.showWhoSent});
  
  @override
  State<Reveals> createState() => _RevealsState();
}

class _RevealsState extends State<Reveals> with SingleTickerProviderStateMixin {
  late AnimationController controller;
 bool? show ;
  @override
  void initState() {
    show=widget.showWhoSent;
    super.initState();
    controller = AnimationController(
      vsync: this
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog( 
        backgroundColor: Colors.transparent,
        content:Container(
          child: Lottie.asset(
            'assets/reveal.json',
            repeat: false,
            controller: controller,
            onLoaded: (composition){
              controller
              ..duration = composition.duration
              ..forward();
            }
            ),
        )
      );
    },
  );
}

 
  Widget build(BuildContext context) { 
    return Container(
      child: Column(
        children: [
          Card(
                color: Colors.teal[100],
                shape: RoundedRectangleBorder( 
                  side: BorderSide( 
                    color: Color.fromARGB(255, 38, 166, 154),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Someone voted you as \n"${widget.message}"',
                      textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                        (show!) ? 
                         Column(
                          children: [
                            SizedBox(height: 20,),
                            (widget.image =='') ?
                            CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 33.0,
                                  child:Icon(Icons.person,size:30),
                                ),
                              ):
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 33.0,
                              backgroundImage: NetworkImage(widget.image), 
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('It was @${widget.sender}',style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                          ]
                          ):
                        TextButton(
                          onPressed: () async {
                            if(widget.reveals>0){
                             await DatabaseServices(uid:FirebaseAuth.instance.currentUser!.uid).isRevealedorNot(true,widget.notiid);
                            setState((){
                              widget.showWhoSent=true;
                              show=true;
                              widget.reveals--;
                              showCustomDialog(context);
                               DatabaseServices(uid:FirebaseAuth.instance.currentUser!.uid).updateReveals(widget.reveals);
                            
                            });
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You dont have reveals left')));
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
                          child: Text('Click To Reveal'),
                        ),
                       Lottie.asset('assets/star.json',height: 80,width: 80),
                    ],
                  ),
                  
                ),
          ),  
        ],
      )

    );
  }
 
}