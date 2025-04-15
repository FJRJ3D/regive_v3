import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'AuthRepository.g.dart';

@riverpod
Future<UserCredential?> signInWithEmailPassword(
  Ref ref,
  String email,
  String password,
) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await _forceTokenRefresh();
    return userCredential;
  } on FirebaseAuthException catch (e) {
    print('Authentication error: ${e.message}');
    return null;
  }
}

@riverpod
Future<UserCredential?> registerWithEmailPassword(
  Ref ref, {
  required String email,
  required String password,
  String? displayName,
}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

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

@riverpod
Future<void> signOut(Ref ref) async {
  await FirebaseAuth.instance.signOut();
}

Future<void> _forceTokenRefresh() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await user.getIdToken(true);
  }
}

@riverpod
Future<String> getUserId(GetUserIdRef ref) async {
  User? user = FirebaseAuth.instance.currentUser;
  if(user == null) {
    return throw Exception('User is not authenticated');
  }
  return user.uid;
}
