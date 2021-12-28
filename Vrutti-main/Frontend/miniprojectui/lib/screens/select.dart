import 'package:flutter/material.dart';
import 'languages.dart';
import 'predict.dart';
import 'welcome.dart';



class SelectScreen extends StatefulWidget {
  static const String id="select_screen";
  @override
  _SelectScreen createState() => _SelectScreen();
}

class _SelectScreen extends State<SelectScreen> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  @override
  void initState(){
    super.initState();
    controller=AnimationController(
      duration:Duration(seconds: 1),
      vsync:this,
      upperBound: 100,
    );
    animation=ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {


      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body:Row(
        children: [
          Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            elevation: 5.0,
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(30.0),
            child: MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
              minWidth: 200.0,
              height: 42.0,
              child: Text(
                'predict',
              ),
            ),
          ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              elevation: 5.0,
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, WelcomeScreen.id);
                },
                minWidth: 200.0,
                height: 42.0,
                child: Text(
                  'Log In',
                ),
              ),
            ),
          ),

      ]
      ),
    );

  }
}