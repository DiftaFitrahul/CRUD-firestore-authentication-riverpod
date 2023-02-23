import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get stateUser => _auth.authStateChanges();

  Future<User?> signUp(String email, String password) async {
    try {
      final userSignUp = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userSignUp.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try{
      final userSignIn = await
        _auth.signInWithEmailAndPassword(email: email, password: password);
        return userSignIn.user;
    }on FirebaseAuthException {
      rethrow;
    }
  }

  void signOut()async{
    await _auth.signOut();
  }
}
