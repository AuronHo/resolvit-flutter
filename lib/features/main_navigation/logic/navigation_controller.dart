import 'package:flutter/material.dart';

class NavigationController extends ChangeNotifier {
  // State: which tab index is currently selected
  int _selectedIndex = 0;

  // Getter: so the UI can read the state
  int get selectedIndex => _selectedIndex;

  // Logic: function to update the state
  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Tell the UI to rebuild
  }
}