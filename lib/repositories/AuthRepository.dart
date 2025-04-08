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
      await _forceTokenRefresh();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Authentication error: ${e.message}');
      return null;
    }
  }

  Future<UserCredential?> registerWithEmailPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (displayName != null) {
        await userCredential.user?.updateDisplayName(displayName);
        await userCredential.user?.reload();
      }
      await _forceTokenRefresh();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Registration error: ${e.message}');
      return null;
    }
  }

  Future<void> _forceTokenRefresh() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.getIdToken(true);
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = ref.read(authProvider);
  return AuthRepository(firebaseAuth);
});
