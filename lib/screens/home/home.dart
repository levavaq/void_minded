import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:void_minded/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();

  final _notations = ["English", "Latin/Standard"];
  String _currentNotation = "English";

  final chordsEN = ["A", "B", "C", "D", "E", "F", "G"];
  final chordsSD = ["La", "Si", "Do", "Re", "Mi", "Fa", "Sol"];
  List<String> _chords = ["A", "B", "C", "D", "E", "F", "G"];
  String _currentChord = "A";
  int _currentIndex = 0;

  final _qualities = ["maj", "min"];
  String _currentQuality = "maj";

  final _tensions = ["5", "7", "maj7", "9"];
  List<bool> _isTensionsChecked = [false, false, false, false];
  String _currentTension = "";

  String jsonChord = "";
  String chordName = "A";
  String chordApi = "A";

  void _incrementCounter() async {
    Response response =
    await get("https://api.uberchord.com/v1/chords/" + chordApi);
    String lol = response.body;

    setState(() {
      jsonChord = lol;
    });
  }

  void _updateCheckBoxTensionsState(int index) {
    switch (index) {
      case 1:
        {
          if (_isTensionsChecked[1]) {
            _isTensionsChecked[2] = false;
          }
        }
        break;

      case 2:
        {
          if (_isTensionsChecked[2]) {
            _isTensionsChecked[1] = false;
          }
        }
        break;
    }
  }

  void _changeCurrentTension() {
    setState(() {
      _currentTension = "";
      for (int i = 0; i < _tensions.length; i++) {
        if (_isTensionsChecked[i]) {
          _currentTension += _tensions[i];
        }
      }
    });
  }

  void _changeChordName() {
    setState(() {
      if (_currentNotation != "English") {
        chordApi = chordsEN.elementAt(_currentIndex);
      } else {
        chordApi = _currentChord;
      }
      chordName = _currentChord;

      if (_currentQuality == "min") {
        chordApi += "_m" + _currentTension;
        chordName += "m" + _currentTension;
      } else if (_currentTension.isNotEmpty) {
        chordApi += "_" + _currentTension;
        chordName += _currentTension;
      }
    });
  }

  void _changeNotation() {
    setState(() {
      if (_currentNotation == "English") {
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
        appBar: AppBar(
          title: Text("Void Minded"),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("logout"),
              onPressed: () async {
                await _authService.signOut();
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Column(children: <Widget>[
                    Text(
                      '$chordName',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      '$jsonChord',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ])),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 0,
              ),
              Container(
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: DropdownButton<String>(
                        items: _chords.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        value: _currentChord,
                        onChanged: (String value) {
                          setState(() {
                            _currentIndex = _chords.indexOf(value);
                            this._currentChord = value;
                            _changeChordName();
                            _incrementCounter();
                          });
                        }),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: <Widget>[
                      for (var quality in _qualities)
                        RadioListTile<String>(
                          title: Text(quality),
                          value: quality,
                          groupValue: this._currentQuality,
                          onChanged: (String value) {
                            setState(() {
                              this._currentQuality = value;
                              _changeChordName();
                              _incrementCounter();
                            });
                          },
                        ),
                    ]),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(children: <Widget>[
                        for (int i = 0; i < _tensions.length; i++)
                          CheckboxListTile(
                              title: Text(_tensions[i]),
                              value: _isTensionsChecked[i],
                              onChanged: (bool value) {
                                setState(() {
                                  _isTensionsChecked[i] = value;
                                  _updateCheckBoxTensionsState(i);
                                  _changeCurrentTension();
                                  _changeChordName();
                                  _incrementCounter();
                                });
                              })
                      ])),
                ]),
              ),
              Container(
                  child: Column(children: <Widget>[
                    Text(
                      'Choose your prefered notation',
                    ),
                    DropdownButton<String>(
                        items: _notations.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        value: _currentNotation,
                        onChanged: (String value) {
                          setState(() {
                            this._currentNotation = value;
                            _changeNotation();
                          });
                        })
                  ]))
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
