import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get stateUser => _auth.authStateChanges();

  Future<void> signUp(String email, String password) async {
    try {
      final userSignUp = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try{
      final userSignIn = await
        _auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException {
      rethrow;
    }
  }

  void signOut()async{
    await _auth.signOut();
  }
}
