import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_ltc/pages/Settings_page.dart';
import 'package:project_ltc/pages/level_page.dart';
import 'package:project_ltc/pages/home_screen_page.dart';
import 'profile_screen_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Track the current selected index
  final _pages = [HomeScreenPage(), ProfileScreenPage(), LevelPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: theme.colorScheme.background,
        color: theme.primaryColor,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the index on tap
          });
        },
        items: [
          Icon(
            Icons.home,
            color: theme.iconTheme.color,
          ),
          Icon(
            Icons.person_2,
            color: theme.iconTheme.color,
          ),
          Icon(
            Icons.menu_book,
            color: theme.iconTheme.color,
          ),
          Icon(
            Icons.settings,
            color: theme.iconTheme.color, 
          ),
        ],
      ),
    );
  }
}
