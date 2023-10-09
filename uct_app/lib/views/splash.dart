
import 'package:flutter/material.dart';
import 'landing.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  //initialize the animation controller for a duration of 500 ms
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    Future.delayed(const Duration(seconds: 1), () {
      _animationController.forward().then((_) {
        //push a replacement of the splash screen to the landing page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
        );
      });
    });
  }
 //
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  //release the resources used by animation controller to reduce memory usage
  @override


  //we will build the scaffold using fade transitions and aplly an axis alignment
  //this is part of the splash screen 
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.blue,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(//define the image asset we will use for the splash screen
                'lib/images/uct_splash.png',
                width: MediaQuery.of(context).size.width * 0.5, 
              ), 
              const SizedBox(height: 30.0),
              const Text(//make a sized text bot that displays DTE to the user for a second
                'DTE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}