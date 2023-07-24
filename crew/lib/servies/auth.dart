import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crew/servies/database.dart';
class AuthServices{
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  MyUser? _userFromFirebaseUser(User user){
    return (user != null ? MyUser(
      uid: user.uid,
      isEmailVerified: user.emailVerified,
      ) : null);
  }
  // auth change user stream

  Stream<MyUser?> get user{
    return _auth.authStateChanges()
    .map((User? user) => _userFromFirebaseUser(user!));
  } 
  // sign in anon
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!); 
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password); 
      User? user = result.user;

      return _userFromFirebaseUser(user!); 
    }
    catch(e){
      print(e.toString());
        return null;
    }
  } 
  
  Future <bool> doesUsernameExistsAlready(String username) async { 

   // we get the registered usernames from our database
   final usernames = await FirebaseFirestore.instance.collection('usersInfo').doc("usernames").get();
   final data = usernames.data() as Map<String, dynamic> ;

   // we return that if a key with that username exists
   return data.containsKey(username);
 }


  // register with email and password

  Future  registerWithEmailAndPassword(String email,String password,String name,String age,String gender) async{
    try{
      
    await FirebaseFirestore.instance.collection('usersInfo').doc("usernames").set({
            name: true,
              }, 
            SetOptions(merge: true) 
            );
   
  
      UserCredential result = await _auth. createUserWithEmailAndPassword(email: email, password: password); 
      User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseServices(uid: (user!.uid)).updateUserData(age, name , 3, 'Hello there!','',gender,0,0);
      return _userFromFirebaseUser(user); 
    }
    catch(e){ 
      print(e.toString());
        return null;
    }
  }
  // sign out
  Future signingOut() async{
      try{
        
        return await _auth.signOut();
      }
      catch(e){
        print(e.toString());
        return null;
      }
  }

}