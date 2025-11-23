import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // We'll need this

// Import the three main screens we are about to create
import '../../home/view/home_screen.dart';
import '../../chat/view/chat_screen.dart';
import '../../profile/view/profile_screen.dart';

// Import a new controller for our navigation
import '../logic/navigation_controller.dart';

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({super.key});

  // This list holds the 3 main screens
  final List<Widget> _screens = const [
    HomeScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Get the controller
    final controller = context.watch<NavigationController>();

    return Scaffold(
      body: IndexedStack(
        // Shows only the screen at the current index
        index: controller.selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Use the state from the controller
        currentIndex: controller.selectedIndex,
        onTap: (index) {
          // Call the function from the controller to change the index
          context.read<NavigationController>().setIndex(index);
        },
        // Styling to match your design
        type: BottomNavigationBarType.fixed, // Shows labels always
        selectedItemColor: Theme.of(context).primaryColor, // kPrimaryBlue
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}