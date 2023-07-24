import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew/servies/auth.dart';
import 'package:crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crew/shared/constants.dart';
import 'package:intl/intl.dart';
class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView()});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController dateInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  bool loading=false;
  //text field state
  String selectedGender = 'male';
  String email='';
  String password='';
  String error='';
  String name='';
  String age='';
  
  bool authorized=false;
   Future <bool> doesUsernameExistsAlready(String username) async { 
            final usernames = await FirebaseFirestore.instance.collection('usersInfo').doc("usernames").get();
            final data = usernames.data() as Map<String, dynamic> ;

            // we return that if a key with that username exists
            return data.containsKey(username);
  }

  @override
  Widget build(BuildContext context) {
    
     return loading ? Loading(): Scaffold(
      backgroundColor: Colors.teal[400],

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Form(
              key: _formKey,
              child:Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                 shape: BoxShape.circle,
                color: Colors.teal[100],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,40,0,0),
                  child: Center(
                    child: (authorized) ?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 280,
                          child: TextFormField(
                                decoration: textInputDecoration.copyWith(hintText:'Email'),
                                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                                onChanged: (val){
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                        ),
                        SizedBox(height: 20,),
                            //password
                          SizedBox(
                            height: 50,
                            width: 280,
                            child: TextFormField(
                                decoration: textInputDecoration.copyWith(hintText:'password'),
                                validator: (value) => value!.length < 6 ? 'Enter a password 6+ chars long' : null,
                                obscureText: true, //to hide password
                                onChanged: (val){
                                   setState(() {
                                    password = val;
                                  });
                                },
                              ),
                          ),
                          SizedBox(height: 20,),
                        //confirm password
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          height: 50,
                          width: 280,
                          child: TextFormField(
                                decoration: textInputDecoration.copyWith(hintText:'confirm password'),
                                validator: (value) => value != password ? 'passwords do not match' : null,
                                obscureText: true, //to hide password
                                onChanged: (val){
                                   setState(() {
                                    
                                  });
                                },
                              ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(Size(100, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(178, 223, 219, 1)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        
                          RoundedRectangleBorder(
                            
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black,width: 2.0),
                            ),
                        ),
                        
                        ),
                        onPressed: ()async {
                         if(_formKey.currentState!.validate()){
                            setState(() {
                              loading=true;
                            });
                           dynamic result = await _auth.registerWithEmailAndPassword(email, password,name,age,selectedGender);
                           if(result == null){
                            setState(() {
                              error='username is taken';
                              loading=false;
                            });
                           }
                         }
                        },
                        child:
                        Text(
                          'Create Account',
                          style: TextStyle(color: Colors.black),
                        ),           
                        ), 
                        Text(error,
                          style:TextStyle(color: Colors.red),
                        ),
                         
                         ElevatedButton(
                        style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(Size(50, 30)),
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(178, 223, 219, 1)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black,width: 2.0),
                            ),
                        ),
                        
                        ),
                        onPressed: ()async {
                          setState(() {
                            authorized=false;
                          });
                        },
                        child:
                        Text(
                          'Back',
                          style: TextStyle(color: Colors.black),
                        ),           
                        ),
                      ],
                    )
                    :
                    Column( 
                      mainAxisAlignment: MainAxisAlignment.center,
                      
                      children: <Widget>[
                        Text('Create account',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
                        //username
                        SizedBox(height: 30),
                        Container(
                
                          height: 50,
                          width: 280,
                          child: TextFormField(
                            decoration: textInputDecoration.copyWith(hintText:'Enter your username'),
                            validator: (value) => value!.length < 6 ? 'Username should be 6+ characters' : null,
                            onChanged: (val) async {
                               setState(() {
                                name = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                      Container(
                        height: 50,
                        width: 280,
                         decoration: BoxDecoration(
                            color: Colors.teal[100],
                            border: Border.all(color: Colors.black,width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                            
                          ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            
                          controller: dateInput,
                          decoration: InputDecoration(
                            
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2.0)
                          ),  
                            icon: Icon(Icons.calendar_today,color: Colors.teal[400],), //icon of text field
                            labelText: "Enter Birth Date" ,
                            labelStyle: TextStyle(
                               color: Colors.black,
                              ),
                            ),
                            readOnly: true,
                              onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2002),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2010));
                                  
                              if (pickedDate != null) {
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  dateInput.text = formattedDate; 
                                  age=formattedDate;
                                  //set output date to TextField value.
                                }
                                );
                              } 
                              else {
                               
                              }
                      },
                    ),
                        ),
                      ), 
                      SizedBox(height: 10),
                          //gender column
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedGender = 'male';
                                          });
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                              color: selectedGender == 'male'
                                  ? const Color.fromARGB(255, 101, 172, 231)
                                  : Colors.teal[200],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.male,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedGender = 'female';
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: selectedGender == 'female'
                                  ? Color.fromARGB(255, 238, 154, 183)
                                  : Colors.teal[200],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.female,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                      ),
                      SizedBox(height: 10),
                      Text(
                      'Selected gender: $selectedGender',
                      style: TextStyle(fontSize: 12),
                      ),
                      ],
                      ),
                    ),
                      const SizedBox(height: 10),
                                ],
                            ),
                        SizedBox(height: 15,),
                        ElevatedButton(onPressed: () async {
                        if(_formKey.currentState!.validate()){
                        var exist = await doesUsernameExistsAlready(name);
                        if(exist){
                          setState(() {
                            authorized=false;
                          });
                        }
                        else{
                          setState(() {
                            authorized=true;
                           });
                          }}
                        },style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(Size(100, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(178, 223, 219, 1)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black,width: 2.0),
                              ),
                          ),
                          
                          ), 
                        child: 
                        Text('Next',style: TextStyle(color: Colors.black,fontSize: 18),),
                        ),
                        
                        SizedBox(height: 10,),
                      ],
                    ),
                    
                  ),
                ),
              ), 
            ),
          ),
           Row(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('Click here to ',style: TextStyle(color: Colors.white),),
               TextButton.icon(
               onPressed: (){
                 widget.toggleView();
               },
               icon: Icon(Icons.person,
               color: Colors.white,),
               label: Text('Sign In',
               style: TextStyle(color: Colors.white),
               ),
               
               ),
                       ],
                     ),
        ],
      ),
     );
  }
}