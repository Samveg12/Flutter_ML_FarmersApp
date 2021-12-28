import 'package:flutter/material.dart';
import 'package:miniprojectui/screens/welcome.dart';
import 'package:miniprojectui/screens/predict.dart';
import 'package:miniprojectui/screens/select.dart';
import 'package:miniprojectui/screens/speech.dart';
import 'package:miniprojectui/screens/languages.dart';
import './screens/planguages.dart';
void main() => runApp(Miniprojectui());

class Miniprojectui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        //SpeakScreen.id:(context)=>SpeakScreen(),
        SelectScreen.id:(context)=>SelectScreen(),
        //PredictScreen.id:(context)=>PredictScreen(),
        Languages.id:(context)=>Languages(),
        PLanguages.id: (context) => PLanguages(),
      },
      //home: Speech2Text(),
    );
  }
}
