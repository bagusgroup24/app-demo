import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthServices {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<auth.User> register(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      auth.User firebaseUser = result.user;

      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<auth.User> login(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      auth.User firebaseUser = result.user;

      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> logout() async {
    _auth.signOut();
  }

  static Stream<auth.User> get userStream => _auth.authStateChanges();
}
