import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 58, 58, 58),
      body: Stack(
        children: [
          const Center(
            child: Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 350,
              padding: const EdgeInsets.all(2.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: const Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
