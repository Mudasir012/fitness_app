import 'package:flutter/material.dart';

import 'screens/signin_signup.dart';

void main() => runApp(const SignUpApp());

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: SignUpScreen());
}
