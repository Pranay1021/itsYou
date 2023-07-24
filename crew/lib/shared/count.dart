import 'package:shared_preferences/shared_preferences.dart';

class Counter{
  static int count=0;
  static int timeRemaining=0;
  Counter(){
    getCounter();
    startCountDown();
    print('constructor ma xa $timeRemaining');
  }
   void getCounter() async{
      var prefs = await SharedPreferences.getInstance();
      var temp  = prefs.getInt('counter');
      if(temp == null || temp <= 0){
        count = 0;
      }
      else{
        count = temp;
      }
  }

 void startCountDown() async {
        print('cout wala time rem $timeRemaining');
        var prefs = await SharedPreferences.getInstance();
        var temp2 = prefs.getInt('timeRemaining');
          if(temp2 == null || temp2 <= 1){
            timeRemaining = 0;
          }
          else{
            timeRemaining = temp2;
          }
}

static incrementCounter() async {
  count++;
  if(count >= 10){
    count = 0;
  }
  var prefs = await SharedPreferences.getInstance();
  await prefs.setInt('counter', count);
}

static saveTimeRem(int rem) async{
  var prefs = await SharedPreferences.getInstance();
  print('save time ma ayo');
  await prefs.setInt('timeRemaining', rem);
} 

}
