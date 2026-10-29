import 'package:flutter/material.dart';

import '../app_style.dart';
import '../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isSignUp = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const AppShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: canvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Brand Header (matching ScreenHeader across the app)
              Row(
                children: [
                  const Icon(Icons.donut_large, color: ink, size: 26),
                  const SizedBox(width: 9),
                  const Text(
                    'HEALTH',
                    style: TextStyle(
                      color: ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _navigateToHome,
                    style: TextButton.styleFrom(
                      foregroundColor: muted,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Skip', style: TextStyle(fontSize: 13)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios, size: 12),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Headline & Subtitle
              Text(
                isSignUp ? 'Start your\njourney.' : 'Welcome\nback.',
                style: const TextStyle(
                  color: ink,
                  fontSize: 32,
                  height: 1.15,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isSignUp
                    ? 'Track your training, habits and daily progress.'
                    : 'Log in to continue where you left off.',
                style: const TextStyle(color: muted, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Segmented Tab Switcher (Sign Up / Sign In)
              Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isSignUp = true),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSignUp ? raisedSurface : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: isSignUp ? ink : muted,
                              fontWeight: isSignUp ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isSignUp = false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: !isSignUp ? raisedSurface : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: !isSignUp ? ink : muted,
                              fontWeight: !isSignUp ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ACCOUNT DETAILS',
                      style: TextStyle(
                        color: muted,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .8,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Full Name (Only on Sign Up)
                    if (isSignUp) ...[
                      _buildInputField(
                        controller: nameController,
                        hint: 'Full name',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Email Address
                    _buildInputField(
                      controller: emailController,
                      hint: 'Email address',
                      icon: Icons.alternate_email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),

                    // Password
                    _buildInputField(
                      controller: passwordController,
                      hint: 'Password',
                      icon: Icons.lock_outline,
                      obscureText: obscurePassword,
                      trailing: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: muted,
                          size: 20,
                        ),
                        onPressed: () => setState(
                          () => obscurePassword = !obscurePassword,
                        ),
                      ),
                    ),

                    // Confirm Password (Only on Sign Up)
                    if (isSignUp) ...[
                      const SizedBox(height: 14),
                      _buildInputField(
                        controller: confirmPasswordController,
                        hint: 'Confirm password',
                        icon: Icons.lock_reset_outlined,
                        obscureText: obscureConfirmPassword,
                        trailing: IconButton(
                          icon: Icon(
                            obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: muted,
                            size: 20,
                          ),
                          onPressed: () => setState(
                            () => obscureConfirmPassword = !obscureConfirmPassword,
                          ),
                        ),
                      ),
                    ],

                    // Forgot Password (On Sign In)
                    if (!isSignUp) ...[
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: orange,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 22),

                    // Primary Action Button (Vibrant Coral Red/Orange Gradient)
                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: const LinearGradient(
                          colors: [red, orange],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: red.withValues(alpha: 0.35),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(26),
                          onTap: _navigateToHome,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isSignUp ? 'Create Account' : 'Sign In',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: .3,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // OR Social section
              const Center(
                child: Text(
                  'OR CONTINUE WITH',
                  style: TextStyle(
                    color: muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .8,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _buildSocialCard(
                      icon: Icons.g_mobiledata,
                      label: 'Google',
                      iconSize: 28,
                      onTap: _navigateToHome,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSocialCard(
                      icon: Icons.apple,
                      label: 'Apple',
                      iconSize: 22,
                      onTap: _navigateToHome,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              // Terms & Privacy Note
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    isSignUp
                        ? 'By signing up, you agree to our Terms of Service\nand acknowledge our Privacy Policy.'
                        : 'Your data is secured with end-to-end encryption.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: muted, fontSize: 11, height: 1.4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? trailing,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: raisedSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: divider.withValues(alpha: 0.5), width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: ink, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: muted, fontSize: 14),
          prefixIcon: Icon(icon, color: orange, size: 20),
          suffixIcon: trailing,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialCard({
    required IconData icon,
    required String label,
    required double iconSize,
    required VoidCallback onTap,
  }) {
    return Material(
      color: surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: divider.withValues(alpha: 0.4), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: ink, size: iconSize),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
