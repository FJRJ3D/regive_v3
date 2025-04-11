import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regive_v3/providers/global_providers.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';

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
        return Container(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        userDetails.imageUrl != null
                            ? NetworkImage(userDetails!.imageUrl!)
                            : AssetImage('assets/images/default_user_photo.png')
                                as ImageProvider,
                  ),
                  Text(
                    userDetails.username,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
