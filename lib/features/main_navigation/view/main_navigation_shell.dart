import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/navigation_controller.dart';

// Screens
import '../../home/view/home_screen.dart';
import '../../chat/view/chat_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../saved/view/saved_screen.dart';

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

    // Warna Baru sesuai request
    const Color navBarColor = Color(0xFF4981FB);

    return Scaffold(
      extendBody: true, 
      body: IndexedStack(
        index: controller.selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        // Margin: Memberi jarak agar melayang
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 20), 
        
        // KITA HAPUS "height: 70" AGAR TIDAK OVERFLOW
        // Container akan menyesuaikan tinggi isi di dalamnya (Icon)
        
        decoration: BoxDecoration(
          color: navBarColor, 
          borderRadius: BorderRadius.circular(25), 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex,
              onTap: (index) {
                context.read<NavigationController>().setIndex(index);
              },
              backgroundColor: navBarColor,
              type: BottomNavigationBarType.fixed,
              
              // --- PENGATURAN AGAR SANGAT PENDEK ---
              // 1. Matikan Label Teks
              showSelectedLabels: false,
              showUnselectedLabels: false,
              
              // 2. Sesuaikan Ukuran Icon
              iconSize: 26, 
              
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.6),
              
              elevation: 0, 
              
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Home', // Label tetap ditulis tapi tidak akan muncul
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border),
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}