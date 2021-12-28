import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import './pages.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

class Speech2Text extends StatefulWidget {
  final countryCode;
  @override
  _Speech2TextState createState() => _Speech2TextState();
  Speech2Text(this.countryCode);
}

class _Speech2TextState extends State<Speech2Text> {
  BuildContext ctx;
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  String translated = '';
  int resultListened = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    _currentLocaleId = widget.countryCode;
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      _localeNames = await speech.locales();

      // var systemLocale = await speech.systemLocale();
      // _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void trans(String input1) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(input1,
        from: _currentLocaleId.substring(0, 2), to: 'en');
    print("translation: ${(translation).toString()}");
    setState(() {
      translated = translation.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Speech to Text Example'),
        ),
        body: Column(children: [
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Initialize'),
                      onPressed: _hasSpeech ? null : initSpeechState,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Start'),
                      onPressed: !_hasSpeech || speech.isListening
                          ? null
                          : startListening,
                    ),
                    FlatButton(
                      child: Text('Stop'),
                      onPressed: speech.isListening ? stopListening : null,
                    ),
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: speech.isListening ? cancelListening : null,
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: <Widget>[
                //     // DropdownButton(
                //     //   onChanged: (selectedVal) {
                //     //     _switchLang(selectedVal);
                //     //     print(_currentLocaleId);
                //     //   //   List lst = []; _localeNames.map(
                //     //   //     (localeName){
                //     //   //       lst.add(localeName.name);
                //     //   //     }
                //     //   //   ).toList();
                //     //   //   print(lst.sublist(100));
                //     //   } ,
                //     //   value: _currentLocaleId,
                //     //   items: _localeNames
                //     //       .map(
                //     //         (localeName) => DropdownMenuItem(
                //     //           value: localeName.localeId,
                //     //           child: Text(localeName.name),
                //     //         ),
                //     //       )
                //     //       .toList(),
                //     // ),
                //   ],
                // )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'Recognized Words',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).selectedRowColor,
                        child: Center(
                          child: Text(
                            ("Original - $lastWords \nTranslated - $translated"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        bottom: 10,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: .26,
                                    spreadRadius: level * 1.5,
                                    color: Colors.black.withOpacity(.05))
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.mic),
                              onPressed: () => null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'Error Status',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                Center(
                  child: Text(lastError),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: speech.isListening
                  ? Text(
                      "I'm listening...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Not listening',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          FlatButton(
            onPressed: () {
              translated = translated.toLowerCase();
              if ((translated.contains("where") &&
                          translated.contains("find") ||
                      translated.contains("buy")) ||
                  translated.contains("search")) {
                Navigator.of(ctx).push(MaterialPageRoute(
                    builder: (BuildContext ctx) => FindUrea(translated,_currentLocaleId.substring(0, 2))));
                    } 
                    
                    
                  else if ((translated.contains("retailers") || translated.contains("retailer")) &&
                  (translated.contains("which") ||
                      translated.contains("who"))) {
                          Navigator.of(ctx).push(MaterialPageRoute(
                    builder: (BuildContext ctx) => Retailer(translated,_currentLocaleId.substring(0, 2))));
                      }

                  else if (translated.contains("mandi") || translated.contains("market")){
                    translated = translated + "mandi";
                    Navigator.of(ctx).push(MaterialPageRoute(
                    builder: (BuildContext ctx) => Mandi(translated,_currentLocaleId.substring(0, 2))));
                  }

                  else if (translated.toLowerCase().contains("news")){
                    Navigator.of(ctx).push(MaterialPageRoute(
                    builder: (BuildContext ctx) => News(translated,_currentLocaleId.substring(0, 2))));
                  }
            },
            child: Text("Next"),
          ),
        ]),
      ),
    );
  }

  void startListening() {
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 5),
        pauseFor: Duration(seconds: 5),
        partialResults: false,
        localeId: widget.countryCode, //_currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {
      translated = '';
    });
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;
    print('Result listener $resultListened');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
      print("Localeeeee");
      print(_currentLocaleId.substring(0, 2));
      print(_currentLocaleId);
      trans(result.recognizedWords);
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    // print(
    // 'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
}
