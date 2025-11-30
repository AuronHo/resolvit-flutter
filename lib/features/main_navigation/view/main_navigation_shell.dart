import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/navigation_controller.dart';

// Screens
import '../../home/view/home_screen.dart';
import '../../chat/view/chat_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../saved/view/saved_screen.dart';

// Widget Baru
import 'widgets/custom_bottom_nav_bar.dart'; 

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    ChatScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavigationController>();

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: controller.selectedIndex,
        children: _screens,
      ),
      // --- PANGGIL WIDGET DISINI ---
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: controller.selectedIndex,
        onTap: (index) {
          // Logika Utama: Ganti halaman di shell ini
          context.read<NavigationController>().setIndex(index);
        },
      ),
    );
  }
}