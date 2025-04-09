import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regive_v3/components/CustomElevatedButton.dart';
import 'package:regive_v3/components/CustomTextField.dart';
import 'package:regive_v3/navigators/AppRouter.dart';
import 'package:regive_v3/repositories/AuthRepository.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _displayNameController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFA354), Color(0xFFE56230)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/ReGive_logo_horizontal.svg', width: 190),
                const SizedBox(height: 40),
                CustomTextField(
                  labelText: 'Display name',
                  hintText: 'Enter your username',
                  prefixIcon: Icons.drive_file_rename_outline,
                  keyboardType: TextInputType.name,
                  controller: _displayNameController,
                ),
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _passwordController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60.0,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      CustomElevatedButton(
                        text: 'Enter',
                        onPressed: () async {
                          final userCredential = await ref.watch(
                            registerWithEmailPasswordProvider(
                              email: _emailController.text,
                              password: _passwordController.text,
                              displayName: _displayNameController.text,
                            ).future,
                          );
                          if (userCredential != null) {
                            AppNavigator().router.go('/');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Password should be at least 6 characters'),
                              ),
                            );
                          }
                        },
                        backgroundColor: const Color(0xFFE66A35),
                        foregroundColor: Colors.white,
                      ),
                      const Spacer(),
                      CustomElevatedButton(
                        text: 'Register',
                        onPressed: () {
                          AppNavigator().router.go('/');
                        },
                        backgroundColor: const Color(0xFFEC914A),
                        foregroundColor: Colors.white,
                        icon: Icons.arrow_back_outlined,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}