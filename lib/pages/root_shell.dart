import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'placeholder_pages.dart';

/// App root: an [IndexedStack] of the four tabs (Home / Search / Saved /
/// Profile) with the shared [AppBottomNav] pinned below. This is what
/// `main.dart` launches as the home screen.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  static const _pages = [
    HomePage(),
    SearchPage(),
    SavedPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: IndexedStack(index: _index, children: _pages)),
            AppBottomNav(currentIndex: _index, onTap: (i) => setState(() => _index = i)),
          ],
        ),
      ),
    );
  }
}
