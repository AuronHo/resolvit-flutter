import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../main_navigation/logic/theme_controller.dart'; 

class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final isDark = themeController.isDarkMode;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0F2027), const Color(0xFF2C5364)] 
                : [kGradientTop, kGradientBottom], 
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                
                // 1. ADJUST TOP MARGIN (Moves "Resolv IT" up or down)
                const SizedBox(height: 60), 

                // --- TITLE ---
                Center(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 40, 
                        color: Colors.white, 
                        fontFamily: 'Roboto', 
                        height: 1.0,
                      ),
                      children: [
                        TextSpan(
                          text: 'Resolv', 
                          style: TextStyle(fontWeight: FontWeight.w300), 
                        ),
                        TextSpan(text: ' '),
                        TextSpan(
                          text: 'IT', 
                          style: TextStyle(fontWeight: FontWeight.bold), 
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. ADJUST GAP (Distance between Title and Logo)
                const SizedBox(height: 100), 

                // --- LOGO ---
                Center(
                  child: Image.asset(
                    'assets/images/resolvit_logo.png', 
                    // 3. ADJUST LOGO HEIGHT (Make it taller/shorter here)
                    height: 300, 
                    fit: BoxFit.contain,
                  ),
                ),

                // This spacer takes up all remaining space to push buttons to bottom
                const Spacer(), 

                // --- BUTTONS ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Google Sign In Logic
                        },
                        icon: Image.asset(
                          'assets/images/google_logo.png', 
                          height: 24,
                        ),
                        label: const Text('Continue with Google'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          elevation: 3,
                          minimumSize: const Size(double.infinity, 50), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/create_account');
                        },
                        child: const Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue, 
                          foregroundColor: Colors.white,
                          elevation: 3,
                          minimumSize: const Size(double.infinity, 50), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // --- FOOTER ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey[600]), 
                    ),
                    GestureDetector(
                      onTap: () {
                        // Login Logic
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: kPrimaryBlue, 
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: kPrimaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}