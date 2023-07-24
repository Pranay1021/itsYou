import 'package:crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String _email = '';

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Password Reset'),
            content: Text(
              'A password reset link has been sent to your email address.',
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } catch (error) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Password Reset'),
            content: Text(
              'Failed to send password reset email. Please try again later.',
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {

                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                  height: 100,
                  width: 300,
                  padding: EdgeInsets.all(16),
                  child: Center(child: Text('Please Enter your email to reset the password',textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontSize: 20))),
                ),
                ),   
               SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: textInputDecoration.copyWith(hintText:'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _resetPassword,
                  child: Text('Reset Password',style: TextStyle(color: Colors.green[900])),
                  style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green[900]!),
                            )
                          )
                        ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
