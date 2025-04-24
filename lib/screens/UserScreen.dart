import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/models/UserDetails.dart';
import 'package:regive_v3/repositories/AuthRepository.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';
import 'package:regive_v3/utils/date_format.dart';
class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});
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
          final detailsAsync = ref.watch(
            fetchUserDetailsByIdProvider(user.uid),
          );

          return detailsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error loading details: $e')),
            data: (details) => _buildProfile(context, details, user, ref),
          );
        },
      ),
    );
  }

  Widget _buildProfile(
    BuildContext context,
    UserDetails details,
    User authUser,
    WidgetRef ref,
  ) {
    final date = details.wasOnline;
    final publishedDate =
    date != null
        ? ref.watch(formatDateProvider(ref, date.toDate()))
        : 'No date';

    return Padding(
      padding: const EdgeInsets.all(16),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Sign out',
                  onPressed: () {
                    ref.read(signOutProvider);
                    GoRouter.of(context).go('/');
                  },
                ),
              ),
            ],
          ),
          Center(
            child:
          Stack(
            alignment: Alignment.bottomRight,
            children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.amberAccent, width: 1.7),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(details.imageUrl),
              ),
            ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 14,
                  child: IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt, color: Colors.brown, size: 12,)),
                ),
              )
            ],
          ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade200, Colors.amber.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                details.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 8),
          // Text('Email: ${authUser.email ?? '—'}'),
          // const SizedBox(height: 8),
          // const Divider(height: 32),
          // Text('Last seen: ${publishedDate}'),
          // const SizedBox(height: 8),
          // const Divider(height: 32),
          Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildTitle(context, "Your data", Icons.date_range, () {
                    GoRouter.of(context).push('/user-data');
                  }),
                  _buildTitle(context, "Change data", Icons.edit, () {
                    GoRouter.of(context).push("/change-data");
                  }),
                  _buildTitle(context, "Activity history", Icons.history, () {
                  }),
                  _buildTitle(context, "Help & support", Icons.help, () {
                    GoRouter.of(context).push("/support");
                  }),
                ],
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, title, IconData icon, VoidCallback onTap) {
    return GestureDetector (
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
            padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.deepOrange),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            ),
          ],
        ),
        ),
      ),
    );
  }
}
