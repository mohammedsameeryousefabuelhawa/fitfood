import 'dart:async';
import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/general.dart';
import 'package:ecommerce/view/screens/main_screen.dart';

import 'login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    General.getPrefString(ConstantValue.Id, "").then(
      (id) {
        Timer(
          const Duration(
            seconds: 3,
          ),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    id == "" ? const LoginScreen() : const MainScreen(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          Center(
            child: Image.asset("assets/images/AppleLogo.png"),
          )
        ],
      ),
    );
  }
}
