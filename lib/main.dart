import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Void Minded',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _notations = ["English","Latin/Standard"];
  String _currentNotation = "English";

  final chordsEN = ["A","B","C","D","E","F","G"];
  final chordsSD = ["La","Si","Do","Re","Mi","Fa","Sol"];
  List<String> _chords = ["A","B","C","D","E","F","G"];
  String _currentChord = "A";
  int _currentIndex = 0;

  final _qualities = ["maj","min"];
  String _currentQuality = "maj";

  final _tensions = ["","5","7","maj7","9"];
  String _currentTension = "";

  String jsonChord = "";
  String chordName = "A";
  String chordApi = "A";


  void _incrementCounter() async {
    Response response = await get("https://api.uberchord.com/v1/chords/" + chordApi);
    String lol = response.body;

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      jsonChord = lol;
    });
  }

  void _changeChordName() {
    setState(() {
      if(_currentNotation != "English") {
        chordApi = chordsEN.elementAt(_currentIndex);
      } else {
        chordApi = _currentChord;
      }
      chordName = _currentChord;

      if(_currentQuality == "min") {
        chordApi += "_m" + _currentTension;
        chordName += "m" + _currentTension;
      } else if(_currentTension.isNotEmpty){
        chordApi += "_" + _currentTension;
        chordName += _currentTension;
      }
    });
  }

  void _changeNotation() {
    setState(() {
      if(_currentNotation == "English") {
        _chords = chordsEN;
      } else {
        _chords = chordsSD;
      }
      _currentChord = _chords.elementAt(_currentIndex);
      _changeChordName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    '$chordName',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    '$jsonChord',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ]
              )
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 0,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: DropdownButton<String>(
                        items: _chords.map((String value){
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value)
                          );
                        }).toList(),
                        value: _currentChord,
                        onChanged: (String value) {
                          setState(() {
                            _currentIndex = _chords.indexOf(value);
                            this._currentChord = value;
                            _changeChordName();
                            _incrementCounter();
                          });
                        }
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        RadioListTile<String>(
                          title: Text(_qualities[0]),
                          value: _qualities[0],
                          groupValue: this._currentQuality,
                          onChanged: (String value) {
                            setState(() {
                              this._currentQuality = value;
                              _changeChordName();
                              _incrementCounter();
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text(_qualities[1]),
                          value: _qualities[1],
                          groupValue: this._currentQuality,
                          onChanged: (String value) {
                            setState(() {
                              this._currentQuality = value;
                              _changeChordName();
                              _incrementCounter();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButton<String>(
                      items: _tensions.map((String value){
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value)
                        );
                      }).toList(),
                      value: _currentTension,
                      onChanged: (String value) {
                        setState(() {
                          this._currentTension = value;
                          _changeChordName();
                          _incrementCounter();
                        });
                      }
                    ),
                  )
                ],
              )
            ),
            Container(
                child: Column(
                    children: <Widget>[
                      Text(
                        'Choose your prefered notation',
                      ),
                      DropdownButton<String>(
                          items: _notations.map((String value){
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value)
                            );
                          }).toList(),
                          value: _currentNotation,
                          onChanged: (String value) {
                            setState(() {
                              this._currentNotation = value;
                              _changeNotation();
                            });
                          }
                      )
                    ]
                )
            )
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
