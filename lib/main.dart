import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
      home: MyHomePage(title: 'Get the chord you want'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _notations = ["English","Latin/Standard"];
  String _currentNotation = "English";

  final _chords_EN = ["A","B","C","D","E","F","G"];
  final _chords_SD = ["La","Si","Do","Re","Mi","Fa","Sol"];
  List<String> _chords = ["A","B","C","D","E","F","G"];
  String _currentChord = "A";
  int _currentIndex = 0;

  final _qualities = ["maj","min"];
  String _currentQuality = "maj";

  final _tensions = ["","5","7","maj7","9"];
  String _currentTension = "";

  String _json_chord = "";
  String _chord_name = "A";
  String _chord_API = "A";


  void _incrementCounter() async {
    Response response = await get("https://api.uberchord.com/v1/chords/" + _chord_API);
    // sample info available in response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String lol = response.body;

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _json_chord = lol;
    });
  }

  void _changeChordName() {
    setState(() {
      if(_currentNotation != "English") {
        _chord_API = _chords_EN.elementAt(_currentIndex);
      } else {
        _chord_API = _currentChord;
      }
      _chord_name = _currentChord;

      if(_currentQuality == "min") {
        _chord_API += "_m" + _currentTension;
        _chord_name += "_m" + _currentTension;
      } else if(_currentTension.isNotEmpty){
        _chord_API += "_" + _currentTension;
        _chord_name += "_" + _currentTension;
      }
    });
  }

  void _changeNotation() {
    setState(() {
      if(_currentNotation == "English") {
        _chords = _chords_EN;
      } else {
        _chords = _chords_SD;
      }
      _currentChord = _chords.elementAt(_currentIndex);
      _changeChordName();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
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
            ),
            Text(
              'Choose you chord',
            ),
            Row(
              children: <Widget>[
                DropdownButton<String>(
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
                DropdownButton<String>(
                    items: _qualities.map((String value){
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value)
                      );
                    }).toList(),
                    value: _currentQuality,
                    onChanged: (String value) {
                      setState(() {
                        this._currentQuality = value;
                        _changeChordName();
                        _incrementCounter();
                      });
                    }
                ),
                DropdownButton<String>(
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
                )
              ],
            ),
            Text(
              '$_chord_name',
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              '$_json_chord',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
