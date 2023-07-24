class MyUser{
  final String? uid;
  final bool? isEmailVerified;
    MyUser({this.uid,this.isEmailVerified});

}

class UserData{
 final String? uid;
  final String? name;
  final String? age;
  final int? reveals;
  final String? bio;
  final String? image;
  final String? gender;
  final int? popularity;
  final int? quesAnswered;
  
  UserData({this.uid,this.name,this.age,this.reveals,this.bio,this.image,this.gender,this.popularity,this.quesAnswered});
  
}

