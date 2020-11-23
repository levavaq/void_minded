import 'package:firebase_auth/firebase_auth.dart';
import 'package:void_minded/models/CustomUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create use obj based on Firebase User
  CustomUser _userFromFirebaseUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // sign in anonymously
  Future signInAnonymously() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User user = credential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign in with email/password

//register with email/password

//sign out

}
