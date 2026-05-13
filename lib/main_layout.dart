import 'package:flutter/material.dart';
import 'pages/home_content.dart';
import 'pages/favorites_page.dart';
import 'pages/profile_page.dart';
import 'widgets/app_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<String> _titles = ['Accueil', 'Favoris', 'Profile'];

  final List<Widget> _screens = [
    const HomeContent(),
    const FavoritesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: _titles[_selectedIndex]),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "favoris"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
    );
  }
}
