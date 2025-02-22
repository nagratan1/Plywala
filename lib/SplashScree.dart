import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

        
          void initState() {
            super.initState();
            Timer(const Duration(seconds: 4),()=> context.go('/onboardingpage'));
          }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
            child: Image.asset('assets/homedepo.png'),
          ),
    );
  }
}