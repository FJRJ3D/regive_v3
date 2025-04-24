import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/components/CustomElevatedButton.dart';
import 'package:regive_v3/components/CustomTextField.dart';
import 'package:regive_v3/navigators/AppRouter.dart';
import 'package:regive_v3/repositories/AuthRepository.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';

class HelpAndSupportScreen extends ConsumerWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E4CF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: const Text(
          'Help & Support',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Need help?',
              style: TextStyle(fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            SizedBox(height: 12),
            Text(
              'If you have any questions or need assistance, please contact us:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '📧 Email: support@regive.app\n📞 Phone: +1 234 567 890\n🕒 Support hours: 9 AM - 5 PM (Mon - Fri)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'FAQs',
              style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            SizedBox(height: 8),
            Text(
                '• How can I reset my password?\n• How to change my email address?\n• How to delete my account?',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}