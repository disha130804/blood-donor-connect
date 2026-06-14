import 'package:flutter/material.dart';
import 'login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  LoginScreen(),
        ),
      );
    });
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {

      // Baad me Login Screen pe navigate karenge

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.favorite,
              color: Colors.white,
              size: 90,
            ),

            SizedBox(height: 20),

            Text(
              "Blood Donor Connect",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Donate Blood, Save Lives",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            Image.asset(
              "assets/images/blood_drop.png",
              width: 180,
            )
          ],
        ),
      ),
    );
  }
}