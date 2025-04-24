import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/models/UserDetails.dart';
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
  required String displayName,
}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await userCredential.user?.updateDisplayName(displayName);
    await userCredential.user?.reload();

    await _forceTokenRefresh();

    final userDetails = FirebaseFirestore.instance.collection('userDetails').doc();
    final generatedUserId = userDetails.id;

    final firebaseUserDetails = userCredential.user;
    if (firebaseUserDetails == null) {
      throw Exception("User creation failed");
    }

    final newUserDetails = UserDetails(
      id: generatedUserId,
      username: displayName,
      imageUrl: "",
      wasOnline: Timestamp.now(),
      userId: firebaseUserDetails.uid,);

    await userDetails.set(newUserDetails.toMap());

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

@riverpod
Future<User?> getUser(GetUserRef ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('User not authenticated');
  }
  return user;
}

@riverpod
Stream<User?> authState(AuthStateRef, ref) {
  return FirebaseAuth.instance.authStateChanges();
}
