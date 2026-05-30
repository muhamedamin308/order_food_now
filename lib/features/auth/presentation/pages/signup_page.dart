import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/core/network/api_error.dart';
import 'package:order_now/features/auth/data/repository/auth_repository.dart';
import 'package:order_now/features/auth/presentation/pages/login_page.dart';
import 'package:order_now/root.dart';
import 'package:order_now/shared/widgets/custom_snackbar.dart';

import '../../../../shared/widgets/custom_primary_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  AuthRepository authRepository = AuthRepository();
  bool isLoading = false;

  Future<void> register() async {
    setState(() => isLoading = true);
    try {
      final user = await authRepository.register(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (user != null) {
        setState(() => isLoading = false);
        if (mounted) {
          CustomSnackBar.showSuccess(context, 'Account created successfully');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (e) => Root()),
          );
        }
      }
    } catch (e) {
      setState(() => isLoading = false);
      String errorMessage = 'error in registration';
      if (e is ApiError) {
        errorMessage = e.toString();
      }
      if (mounted) {
        CustomSnackBar.showError(context, errorMessage);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      register();
    }
  }

  void _navigateToLogin() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _nameController,
                    label: 'Name',
                    hint: 'Enter your name',
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.name,
                    isRequired: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Name is required';
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _emailController,
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
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _passwordController,
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

                  isLoading
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CupertinoActivityIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : CustomPrimaryButton(
                          text: 'Sign Up',
                          onPressed: _handleSignup,
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.background,
                        ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: _navigateToLogin,
                        child: Text(
                          'Login Now',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
