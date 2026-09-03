import 'package:flutter/material.dart';
import 'explore_tab.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ExploreTab(),
    const Center(child: Text("Search Tab", style: TextStyle(color: Colors.white))),
    const Center(child: Text("Browse Tab", style: TextStyle(color: Colors.white))),
    const Center(child: Text("Profile Tab", style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 430,
          height: 932,
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Scaffold(
              backgroundColor: const Color(0xFF121212),
              body: _screens[_currentIndex],
            ),
          ),
        ),
      ),
    );
  }
}