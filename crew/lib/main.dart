import 'package:crew/screens/authenticate/forget.dart';
import 'package:crew/screens/home/home.dart';
import 'package:crew/screens/home/splashScreen.dart';
import 'package:crew/screens/wrapper.dart';
import 'package:crew/servies/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';

 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
   return StreamProvider<MyUser?>.value(
      catchError: (_, __) => null,
      value: AuthServices().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen() ,

        routes: {
        '/wrapper': (context) => Wrapper(), 
        '/home':(context) => Home(),
        '/forget':(context) => ForgotPasswordPage(),
        // Route to your main widget
        },
      ),
    );
  }
}