import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/models/UserDetails.dart';
import 'package:regive_v3/repositories/AuthRepository.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';

class ConfigurationScreen extends ConsumerWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(getUserProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF3E4CF),
      body: authAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Auth error: $e')),
        data: (user) {
          if (user == null) {
            return const Center(child: Text('User is not logged'));
          }
          final detailsAsync = ref.watch(fetchUserDetailsByIdProvider(user.uid));

          return detailsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error loading details: $e')),
            data: (details) => _buildProfile(context, details, user, ref),
          );
        },
      ),
    );
  }


  Widget _buildProfile(BuildContext context, UserDetails details, User authUser, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(onPressed: () async {
            ref.read(signOutProvider);
          GoRouter.of(context).go('/');
          },
         child: Text('Leave')),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(details.imageUrl),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              details.username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Text('Email: ${authUser.email ?? '—'}'),
          const SizedBox(height: 8),
          const Divider(height: 32),
          Text('Last seen: ${details.wasOnline.toDate()}'),
          const SizedBox(height: 8),
          const Divider(height: 32),
          Text('Last seen: ${details.wasOnline.toDate()}'),
          const SizedBox(height: 8),
          const Divider(height: 32),
        ],
      ),
    );
  }
}