import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'tab_bar.dart';

class MainShell extends StatefulWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Update index based on current location
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/timeline')) {
      _currentIndex = 0;
    } else if (location.startsWith('/retrospect')) {
      _currentIndex = 1;
    } else if (location.startsWith('/profile')) {
      _currentIndex = 2;
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomTabBar(
        selectedIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        context.go('/timeline');
        break;
      case 1:
        context.go('/retrospect');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }
}
