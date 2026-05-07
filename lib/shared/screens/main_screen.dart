import 'package:flutter/material.dart';
import '../widgets/nav_bar/bottom_nav_bar.dart';
import '../../features/authors/presentation/screens/authors_screen.dart';
import '../../features/books/presentation/screens/books_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

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
