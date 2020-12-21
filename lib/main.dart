import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_gutenberg/pages/homepage.dart';
import 'package:project_gutenberg/utils/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Gutenberg',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF5E56E7),
        primaryColorDark: Color(0xFF333333),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AppWidgets appWidgets = new AppWidgets();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimeout();
  }

  startTimeout() {
    return new Timer(Duration(seconds: 1), changeScreen);
  }

  changeScreen() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/icon.png", height: 150, width: 150, fit: BoxFit.fill,),
              SizedBox(height: 30),
              Text("Project Gutenberg", style: appWidgets.headText(48),),
              SizedBox(height: 15),
              Text("Read book , websites or pdf , available according to the categories", style: appWidgets.titleText(20),),
            ],
          ),
        ),
      ),
    );
  }
}

