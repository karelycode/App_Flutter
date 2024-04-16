import 'dart:async';

import 'package:flutter/material.dart';
import 'package:segundaapp/pages/fotos.dart';
import 'package:segundaapp/pages/start.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState  extends State{
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
            () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) {
                return Start();//Start();//MyHomePage();
              }
          ));
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo2.jpg'),
      ),
    );
  }
}