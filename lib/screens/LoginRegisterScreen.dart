import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regive_v3/components/CustomElevatedButton.dart';
import 'package:regive_v3/components/CustomTextField.dart';
import 'package:regive_v3/navigators/AppRouter.dart';
import 'package:regive_v3/repositories/AuthRepository.dart';

class LoginRegisterScreen extends ConsumerStatefulWidget {
  const LoginRegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginRegisterScreen> createState() =>
      _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends ConsumerState<LoginRegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final authRepository = ref.read(authRepositoryProvider);
    final userCredential = await authRepository.signInWithEmailPassword(
      _emailController.text,
      _passwordController.text,
    );

    if (userCredential != null) {
      AppNavigator().router.go('/main');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Authentication failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                SvgPicture.asset('assets/ReGive_logo.svg', width: 150),
                const SizedBox(height: 40),
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
                        text: 'Login',
                        onPressed: () async {
                          await _login();
                        },
                        backgroundColor: const Color(0xFFF6AE78),
                        foregroundColor: Colors.white,
                      ),
                      const Spacer(),
                      CustomElevatedButton(
                        text: 'Register',
                        onPressed: () {
                          print('Register button pressed');
                        },
                        backgroundColor: const Color(0xFFE66A35),
                        foregroundColor: Colors.white,
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
