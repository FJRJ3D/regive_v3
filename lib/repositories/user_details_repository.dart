import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:regive_v3/models/UserDetails.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'user_details_repository.g.dart';

class UserDetailsRepository {
  final FirebaseFirestore firestore;

  UserDetailsRepository(this.firestore);

  Future<List<UserDetails>> fetchUserDetailsByIdsList(List<String> idsList) async {
    try {
      final userDetailsSnapshot = await firestore.collection('userDetails').where(FieldPath.documentId, whereIn: idsList.take(10)).get();
      final userDetailsList = userDetailsSnapshot.docs.map((doc) => UserDetails.formDocumentSnapshot(doc)).toList();
      return userDetailsList;
    } catch (error) {
    throw Exception('Failed to fetch usersData: $error');
    }
  }
}

@riverpod
UserDetailsRepository userDetailsRepository(UserDetailsRepositoryRef ref) {
  return UserDetailsRepository(FirebaseFirestore.instance);
}