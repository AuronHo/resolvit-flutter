import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// 1. We extend "ChangeNotifier". This class can "notify"
//    the UI when its data changes.
class AuthController extends ChangeNotifier {

  // --- STATE VARIABLES ---

  // 2. We make the state "private"
  bool _isPasswordVisible = false;
  bool _agreedToTerms = false;

  // 3. We create public "getters" for the UI to read the state
  bool get isPasswordVisible => _isPasswordVisible;
  bool get agreedToTerms => _agreedToTerms;

  // --- LOGIC METHODS ---

  // 4. This method updates the state and "notifies" the UI
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners(); // This tells the UI to rebuild!
  }

  // 5. This method also updates the state and notifies
  void setAgreedToTerms(bool? value) {
    _agreedToTerms = value ?? false;
    notifyListeners(); // This tells the UI to rebuild!
  }

  // 6. This logic was moved from the screen
  Future<void> launchTermsUrl() async {
    final Uri url = Uri.parse('https://your-website.com/terms');
    if (!await launchUrl(url)) {
      // It's better to return an error or let the UI
      // handle showing a SnackBar
      throw 'Could not launch $url';
    }
  }

  // 7. This is your main registration logic.
  // We'll make it return a boolean for success/failure
  // so the UI can show the right SnackBar.
  Future<bool> registerUser() async {
    // This is where you would get your form data
    // and send it to Firebase or your API.
    
    // For now, we just simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // Let's pretend it was successful
    print('--- REGISTRATION LOGIC RAN SUCCESSFULLY ---');
    return true; 
    
    // If it failed, you would: return false;
  }

  // Fungsi Login Dummy
  Future<bool> loginUser() async {
    // Simulasi loading 2 detik
    await Future.delayed(const Duration(seconds: 2));
    
    // Disini nanti logika ke API/Firebase
    // Untuk sekarang kita anggap selalu sukses
    return true; 
  }
}