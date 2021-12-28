import 'package:flutter/material.dart';
import 'package:miniprojectui/screens/predict.dart';
import 'package:miniprojectui/screens/speech.dart';
import './select.dart';



class PLanguages extends StatefulWidget {
  static const String id="planguages_screen";
  @override
  _PLanguages createState() => _PLanguages();
}

class _PLanguages extends State<PLanguages> with SingleTickerProviderStateMixin{
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
    data: new ThemeData.light();
    final countries = ['Arabic (Egypt)', 'Bangla (India)','English (United Kingdom)',  'Gujarati (India)', 'Hindi (India)', 'Kannada (India)', 'Tamil (India)', 'Malayalam (India)', 'Marathi (India)', 'Urdu (India)','Telugu (India)'];
    final countryCode = ['ar_EG', 'bn_IN', 'en_GB', 'gu_IN', 'hi_IN', 'kn_IN', 'ta_IN', 'ml_IN', 'mr_IN', 'ur_IN', 'te_IN'];
    return Scaffold(

      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: ListTile(
                title: Text(countries[index],style: TextStyle(
                  color: Colors.black
                ),
                ),
                onTap: (){
                  print(countries[index]);
                  print(countryCode[index]);
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext ctx) => PredictScreen(countryCode[index])));
                },
                trailing: Icon(Icons.keyboard_arrow_right,color: Colors.black,),
              ),
            );
          },
        ),
      )
    );
  }

  }
