import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, '/wrapper');
      }
    });

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal[200],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _animationController.drive(
                        Tween<double>(begin: 0.5, end: 1.0).chain(
                          CurveTween(curve: Curves.easeOutBack),
                        ),
                      ),
                      child: AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          'ItsYou',
                          textStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          colors: [
                            Colors.teal,
                            Colors.blue,
                            Colors.white,
                            Colors.amber,
                          ],
                          speed: Duration(milliseconds: 800),
                        ),
                      ],
                    ),
                    ),
                    SizedBox(height: 16),
                    SpinKitFadingCube(
                      color: Colors.teal[900],
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
            
          ),
          SizedBox(height: 100,),
          Container(
            decoration: BoxDecoration(
              border: Border.fromBorderSide(BorderSide(color: Colors.white)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text("A work in Development",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
