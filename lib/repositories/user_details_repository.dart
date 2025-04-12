import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:regive_v3/models/UserDetails.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'user_details_repository.g.dart';

class UserDetailsRepository {
  final FirebaseFirestore firestore;

  UserDetailsRepository(this.firestore);

  Future<List<UserDetails>> fetchUserDetailsByUserIdsList(List<String> userIdsList) async {
      final limitedUserIds = userIdsList.take(10).toList();
      final userDetailsSnapshot = await firestore
          .collection('userDetails')
          .where('userId', whereIn: limitedUserIds)
          .get();
      
      final userDetailsList = userDetailsSnapshot.docs
        .map((doc) => UserDetails.formDocumentSnapshot(doc))
        .toList();
      return userDetailsList;
  }

  Future<UserDetails> fetchUserDetailsByUserId(String userId) async {
      final querySnapshot = await firestore
          .collection('userDetails')
          .where('userId', isEqualTo: userId)
          .get();
      
      if(querySnapshot.docs.isNotEmpty) {
        return UserDetails.formDocumentSnapshot(querySnapshot.docs.first);
      } else {
        throw Exception('UserDetails not found for userId: $userId');
      }
  }
}

@riverpod
UserDetailsRepository userDetailsRepository(UserDetailsRepositoryRef ref) {
  return UserDetailsRepository(FirebaseFirestore.instance);
}

@riverpod
Future<UserDetails> fetchUserDetailsById(FetchUserDetailsByIdRef ref, String userDetailsId) async {
  final repo = ref.watch(userDetailsRepositoryProvider);
  return repo.fetchUserDetailsByUserId(userDetailsId);
}