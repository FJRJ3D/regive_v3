import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/components/CustomElevatedButton.dart';
import 'package:regive_v3/components/CustomTextField.dart';
import 'package:regive_v3/navigators/AppRouter.dart';
import 'package:regive_v3/repositories/AuthRepository.dart';
import 'package:regive_v3/repositories/user_details_repository.dart';

class UserChangeDataScreen extends ConsumerStatefulWidget {
  const UserChangeDataScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserChangeDataScreen> createState() => _UserChangeDataScreenState();
}

class _UserChangeDataScreenState extends ConsumerState<UserChangeDataScreen> {
  bool _isEditingUsername = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(getUserProvider);

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
          'Change your data',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: authAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Auth error: $e')),
        data: (user) {
          if (user == null) {
            return const Center(child: Text('User is not logged in'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEditableRow(
                  title: 'Change username',
                  isEditing: _isEditingUsername,
                  controller: _usernameController,
                  onEdit: () => setState(() => _isEditingUsername = true),
                  onCancel: () => setState(() => _isEditingUsername = false),
                ),
                const SizedBox(height: 16),
                _buildEditableRow(
                  title: 'Change email',
                  isEditing: _isEditingEmail,
                  controller: _emailController,
                  onEdit: () => setState(() => _isEditingEmail = true),
                  onCancel: () => setState(() => _isEditingEmail = false),
                ),
                const SizedBox(height: 16),
                _buildEditableRow(
                  title: 'Change password',
                  isEditing: _isEditingPassword,
                  controller: _passwordController,
                  onEdit: () => setState(() => _isEditingPassword = true),
                  onCancel: () => setState(() => _isEditingPassword = false),
                  isPassword: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableRow({
    required String title,
    required bool isEditing,
    required TextEditingController controller,
    required VoidCallback onEdit,
    required VoidCallback onCancel,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        isEditing
            ? Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Input new value',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () {
                print('OK: ${controller.text}');
                onCancel();
              },
              child: const Text('OK', style: TextStyle(color: Colors.brown)),
            ),
          ],
        )
            : TextButton(
          onPressed: onEdit,
          child: const Text('Edit', style: TextStyle(color: Colors.brown)),
        ),
      ],
    );
  }
}
