import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';
import 'package:regive_v3/utils/date_format.dart';
class OwnerComponent extends ConsumerWidget {
  const OwnerComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetailsId = ref.watch(activeProductOwnerProvider);
    if (userDetailsId == null) {
      return const Center(child: Text('Product is not selected'));
    }
    final userDetails = ref.watch(fetchUserDetailsByIdProvider(userDetailsId));
    return userDetails.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (userDetails) {
        if (userDetails == null) {
          return const Center(child: Text('No user details found'));
        }
        final userWasLastTime = ref.watch(formatDateProvider(ref ,userDetails.wasOnline.toDate()));
        return Card(
          elevation: 2,
          margin: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amberAccent, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.grey,
                    backgroundImage: userDetails.imageUrl != null
                    ? NetworkImage(userDetails.imageUrl!)
                    : const AssetImage('assets/images/default_user_photo.png')
                    as ImageProvider,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userDetails.username,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "was online ${userWasLastTime}",
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
