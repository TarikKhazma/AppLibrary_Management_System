import 'package:flutter/material.dart';
import '../../widgets/nav_bar/bottom_nav_bar.dart';
import '../authors/authors_screen.dart';
import '../books/books_screen.dart';
import '../home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NavItem _currentItem = NavItem.home;

  void _onNavItemSelected(NavItem item) {
    if (_currentItem == item) return;
    setState(() => _currentItem = item);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentItem.index,
      children: [
        HomeScreen(
          currentNavItem: _currentItem,
          onNavItemSelected: _onNavItemSelected,
        ),
        BooksScreen(
          currentNavItem: _currentItem,
          onNavItemSelected: _onNavItemSelected,
        ),
        AuthorsScreen(
          currentNavItem: _currentItem,
          onNavItemSelected: _onNavItemSelected,
        ),
      ],
    );
  }
}
