import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../authors/presentation/cubits/authors_cubit.dart';
import '../../../authors/presentation/screens/authors_screen.dart';
import '../../../books/presentation/cubits/books_cubit.dart';
import '../../../books/presentation/screens/books_screen.dart';
import 'home_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../../../trash/presentation/cubits/trash_cubit.dart';
import '../../../trash/presentation/screens/trash_screen.dart';
import '../../../../core/widgets/nav_bar/bottom_nav_bar.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<BooksCubit>()..loadBooks()),
        BlocProvider(create: (_) => getIt<AuthorsCubit>()..loadAuthors()),
        BlocProvider(create: (_) => getIt<TrashCubit>()),
      ],
      child: IndexedStack(
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
          SearchScreen(
            currentNavItem: _currentItem,
            onNavItemSelected: _onNavItemSelected,
          ),
          TrashScreen(
            currentNavItem: _currentItem,
            onNavItemSelected: _onNavItemSelected,
          ),
        ],
      ),
    );
  }
}
