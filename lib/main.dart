import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:void_minded/models/custom_user.dart';
import 'package:void_minded/screens/wrapper.dart';
import 'package:void_minded/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.white,
          ),
          textTheme: GoogleFonts.bellotaTextTheme(Theme.of(context).textTheme)
              .copyWith(
            bodyText2:
                GoogleFonts.bellota(textStyle: TextStyle(color: Colors.white)),
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}
