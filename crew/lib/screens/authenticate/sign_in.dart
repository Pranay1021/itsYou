import 'package:crew/servies/auth.dart';
import 'package:flutter/material.dart';
import 'package:crew/shared/constants.dart';
import 'package:crew/shared/loading.dart';
class SignIn extends StatefulWidget {
  SignIn({required this.toggleView()});

  final Function toggleView;
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool loading=false;
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  //text field state
  String email='';
  String password='';
  String error='';

   final List<Widget> containers = [
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.teal[100],
      
      ),
      child:Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(child: Text('Welcome\n\nPlease Sign in\nor\nRegister if you are new',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
      ),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.teal[400],
      
      
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
        SizedBox(height: 20,),
            Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal[100],
              ),
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Form(
                key: _formKey,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Sign In',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                    SizedBox(height: 40,),
                    //email
                    Container(
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
                    Container(
                      width: 280,
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Password'),
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
                    ElevatedButton(
                      
                    onPressed: ()async {
                       if(_formKey.currentState!.validate()){
                        setState(() {
                          loading=true;
                        });
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if(result == null){
                        setState(() {
                          error='Could not sign in with those credentials';
                          loading=false;
                        });
                       }
                       }
                    },
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
                    child:
                    Text(
                      'Sign In',
                      style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic),
                      ),          
                    ),
                     Text(error,
                      style:TextStyle(color: Colors.red),
                    ),
                  ],
                ), 
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80,0,0,0),
              child: Row(
                children: [
                  Text('If you are new:',style: TextStyle(color: Colors.white),),
                  TextButton.icon(
                  onPressed: (){
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person,
                  color: Colors.white,),
                  label: Text('Create Account',
                  style: TextStyle(color: Colors.white),
                  ),
                  
                  ),
                ],
              ),
            ),
                TextButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(context, '/forget');
                  },
                  icon: Icon(Icons.person,
                  color: Colors.white,),
                  label: Text('Forgot Password',
                  style: TextStyle(color: Colors.white),
                  ),
                  
                  ),
          ],
          
        ),
      )

    );
  }
}