import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/features/auth/presentation/pages/signup_page.dart';
import 'package:order_now/root.dart';

import '../../../../shared/widgets/custom_primary_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => const Root()));
    }
  }

  void _navigateToSignUp() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => const SignupPage()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  // App Title
                  Center(
                    child: Text(
                      'Order Now',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontFamily: 'Chewy',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Welcome Back!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  const SizedBox(height: 8),
                  CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    isRequired: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Email is required';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(height: 8),
                  CustomTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    obscureText: _obscurePassword,
                    onSuffixIconPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    isRequired: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Password is required';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  // Login Button
                  CustomPrimaryButton(
                    text: 'Login',
                    onPressed: _handleLogin,
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.background,
                  ),
                  const SizedBox(height: 24),
                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: _navigateToSignUp,
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Guest Login
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const Root()),
                        );
                      },
                      child: Text(
                        'Continue as a Guest',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
