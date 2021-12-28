import 'package:flutter/material.dart';
import 'planguages.dart';
import 'languages.dart';
import 'predict.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id="welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
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
      backgroundColor:Color.fromRGBO(250,250,250,0.99),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('images/logo.jpeg'),
                height: 200,
                width: 200,
                margin: const EdgeInsets.only(bottom: 30.0),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TypewriterAnimatedTextKit(
                text:['VRUTTI'],
                textStyle: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PLanguages.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Predict the disease',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Languages.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Ask Something',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
