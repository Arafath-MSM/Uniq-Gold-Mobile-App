import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavScaffold extends StatelessWidget {
  const AppBottomNavScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  static const List<String> _tabs = <String>[
    '/home',
    '/catalog',
    '/cart',
    '/profile',
  ];

  int _currentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    final int index = _tabs.indexWhere(location.startsWith);
    return index >= 0 ? index : 0;
  }

  void _onTap(BuildContext context, int index) {
    context.go(_tabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (int index) => _onTap(context, index),
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Catalog',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
