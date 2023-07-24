import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew/model/user.dart';
import 'package:crew/servies/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:crew/shared/loading.dart';

class Settings_Form extends StatefulWidget {
  const Settings_Form({super.key});

  @override
  State<Settings_Form> createState() => _Settings_FormState();
}

class _Settings_FormState extends State<Settings_Form> {
  Future <bool> doesUsernameExistsAlready(String username) async { 
            final usernames = await FirebaseFirestore.instance.collection('usersInfo').doc("usernames").get();
            final data = usernames.data() as Map<String, dynamic> ;
            return data.containsKey(username);
  }
  
  final _formKey = GlobalKey<FormState>();

  //form values
   String? _currentName;
   String? _currentBio;
   

  @override
  Widget build(BuildContext context) {
    final f_user = Provider.of<MyUser?>(context);
    

    return Container(
      child: StreamBuilder<UserData>(
        stream: DatabaseServices (uid:f_user?.uid ?? '').user_doc_stream,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                      Text(
                        'Profile',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      //username update
                      Row(
                        
                        children: <Widget>[
                          Text('Username : ',style: TextStyle(color: Colors.black,
                          fontSize: 18),),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: TextFormField(

                                maxLength: 16,
                                initialValue: userData!.name,
                                validator: (val) =>  val!.length < 6 ? 'Please enter a valid name(6+ characters long)' : null,
                                onChanged: (val) => setState(() => _currentName = val),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      //bio text
                      Row(
                        
                        children: <Widget>[
                          Text('Bio :',style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            ),),
                          SizedBox(width: 69.0),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 6,
                              maxLength: 100,
                              inputFormatters: [
                                TextInputFormatter.withFunction((oldValue, newValue) {
                                  int newLines = newValue.text.split('\n').length;
                                  if (newLines > 3) {
                                    return oldValue;
                                  } else {
                                    return newValue;
                                  }
                                }),
                            ],
                                  initialValue: userData.bio,
                                  validator: (val) => val!.isEmpty ? 'Write on your bio' : null,
                                  onChanged: (val) => setState(() => _currentBio = val),
                              ),
                          ),
                        ],
                      ),
                     
                    SizedBox(height: 20.0),
                      //button
                      ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(Size(100, 40)),
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(178, 223, 219, 1)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                              RoundedRectangleBorder(
                                
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black,width: 2.0),
                                ),
                              ),

                          ),
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.teal),
                        ),
                        onPressed: () async {

                          
                          if(_formKey.currentState!.validate()){
                          
                          if(_currentBio == null && _currentName == null){
                                    Navigator.pop( context);
                                    return;
                                }

                          else if(_currentName == null && _currentBio != null){
                                await DatabaseServices(uid: f_user?.uid ?? '').updateUserData(
                                  userData.age!,_currentName ?? userData.name! ,userData.reveals!, 
                                _currentBio ?? userData.bio!, userData.image!,userData.gender!,userData.popularity!,userData.quesAnswered!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Profile updated sucessfully'),
                                  duration: Duration(seconds: 2),
                                  ),
                              );
                              Navigator.pop(context);
                          }

                          else{
                          var exist =await doesUsernameExistsAlready(_currentName!);
                            if(exist){
                             ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Username already exists'),
                                  duration: Duration(seconds: 2),
                                  ),
                              );
                            }
                          
                            else{
                                await FirebaseFirestore.instance.collection('usersInfo').doc("usernames").set({
                                  userData.name!: FieldValue.delete(),
                                        }, 
                                      SetOptions(merge: true)
                                );
                                await FirebaseFirestore.instance.collection('usersInfo').doc("usernames").set({
                                _currentName!: true,
                                      }, 
                                    SetOptions(merge: true) 
                                    );
                                await DatabaseServices(uid: f_user?.uid ?? '').updateUserData(
                                  userData.age!,_currentName ?? userData.name! ,userData.reveals!, 
                                _currentBio ?? userData.bio!, userData.image!,userData.gender!,userData.popularity!,userData.quesAnswered!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Profile updated sucessfully'),
                                      duration: Duration(seconds: 2),
                                      ),
                                  );
                                Navigator.pop(context);
                            }
                            //auto closes the form
                            }
                          }
                        },
                      ),
                    ],
                  ),
              ),
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