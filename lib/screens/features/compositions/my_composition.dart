import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:void_minded/animations/loading.dart';
import 'package:void_minded/models/composition.dart';
import 'package:void_minded/models/custom_user.dart';
import 'package:void_minded/screens/features/compositions/compositions_list.dart';
import 'package:void_minded/services/composition_service.dart';
import 'package:void_minded/services/mind_service.dart';

class MyComposition extends StatefulWidget {
  @override
  _MyCompositionState createState() => _MyCompositionState();
}

class _MyCompositionState extends State<MyComposition> {
  Stream<List<Composition>> getList(String uid) {
    return CompositionService(uid: uid).compositions;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    return StreamBuilder<CustomUserData>(
        stream: MindService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CustomUserData userData = snapshot.data;
            return StreamProvider<List<Composition>>.value(
              value: getList(userData.uid),
              child: Scaffold(
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Expanded(flex: 1, child: CompositionsList()),
                    ])),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
