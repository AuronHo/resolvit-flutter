import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1. Imports for Logic/State
import 'features/auth/logic/auth_controller.dart';
import 'features/main_navigation/logic/navigation_controller.dart';
import 'features/main_navigation/logic/theme_controller.dart'; // Ensure you created this file

// 2. Imports for Colors
import 'constants/app_colors.dart';

// 3. Imports for Screens
import 'features/auth/view/splash_screen.dart';
import 'features/auth/view/auth_welcome_screen.dart';
import 'features/auth/view/create_account_screen.dart';
import 'features/main_navigation/view/main_navigation_shell.dart';
// import 'features/service/view/service_detail_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => NavigationController()),
        ChangeNotifierProvider(create: (_) => ThemeController()), // Crucial for the toggle
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the theme controller to detect changes (Light vs Dark)
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      title: 'Resolv IT',
      debugShowCheckedModeBanner: false,

      // --- LIGHT THEME CONFIGURATION ---
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kPrimaryBlue, // Uses your #173DDC
        scaffoldBackgroundColor: Colors.white,
        
        // Default styling for Elevated Buttons in Light Mode
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryBlue, 
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minimumSize: const Size(double.infinity, 50),
            elevation: 2,
          ),
        ),
        
        // Default styling for Outlined Buttons
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black87,
            side: const BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),

        // Default styling for Input Fields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        // Ensure color scheme matches your blue
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kPrimaryBlue,
          secondary: kPrimaryBlue,
        ),
      ),

      // --- DARK THEME CONFIGURATION ---
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryBlue,
        scaffoldBackgroundColor: const Color(0xFF121212), // Standard Dark Grey
        
        // Default styling for Elevated Buttons in Dark Mode
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryBlue,
            foregroundColor: Colors.white,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: kPrimaryBlue,
          secondary: kPrimaryBlue,
        ),
      ),

      // This connects the app to the controller's current mode
      themeMode: themeController.themeMode,

      // Start at Splash
      home: const SplashScreen(),

      // Route Definitions
      routes: {
        '/welcome': (context) => const AuthWelcomeScreen(),
        '/create_account': (context) => const CreateAccountScreen(),
        '/home': (context) => const MainNavigationShell(),
        // '/service_detail': (context) => const ServiceDetailScreen(),
      },
    );
  }
}