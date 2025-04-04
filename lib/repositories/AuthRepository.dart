import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error de autenticación: ${e.message}');
      return null;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = ref.read(authProvider);
  return AuthRepository(firebaseAuth);
});
