import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../widgets/auth_appbar.dart';
import '../widgets/auth_tab_bar.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/phone_number_field.dart';
import 'confirm_account_screen.dart';

/// Login screen for user authentication
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late PageController _pageController;
  int _currentTabIndex = 0;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fullNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(title: 'Log in or Sign up', showBackButton: false),
      body: Column(
        children: [
          48.sH,
          // Custom Tab Bar
          Padding(
            padding: 20.padH,
            child: AuthTabBar(
              currentTabIndex: _currentTabIndex,
              onLoginTap: () {
                setState(() => _currentTabIndex = 0);
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              onSignUpTap: () {
                setState(() => _currentTabIndex = 1);
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          // Page View
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentTabIndex = index);
              },
              children: [
                // Log In Tab
                _buildLoginForm(),
                // Sign Up Tab
                _buildSignUpForm(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentTabIndex == 0) {
                    // Log in action
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  } else {
                    // Sign up action
                    // Get email from controller
                    final email = _emailController.text.isNotEmpty
                        ? _emailController.text
                        : 'your email address';

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConfirmAccountScreen(email: email),
                      ),
                    );
                  }
                },
                child: Text(
                  _currentTabIndex == 0 ? 'Log in' : 'Sign up',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            20.sH,
            // Terms text
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'By Continuing, it means you have read and accept our\n',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms of Services',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Login form widget - Email or Phone only
  Widget _buildLoginForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        children: [
          16.sH,
          // Email or Phone field
          AuthTextField(
            label: 'Email or Phone',
            hintText: 'Enter your email or phone number',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
        ],
      ),
    );
  }

  /// Sign up form widget - Full Name, Email, and Phone
  Widget _buildSignUpForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        children: [
          16.sH,
          // Full Name field
          AuthTextField(
            label: 'Full Name',
            hintText: 'Enter your full name',
            keyboardType: TextInputType.name,
            controller: _fullNameController,
          ),
          16.sH,
          // Email field
          AuthTextField(
            label: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          16.sH,
          // Phone Number field
          PhoneNumberField(
            label: 'Phone Number',
            hintText: '080 ••• •••',
            controller: _phoneController,
          ),
        ],
      ),
    );
  }
}
