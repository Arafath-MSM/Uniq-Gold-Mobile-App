import 'package:flutter/material.dart';

class StaticPage extends StatelessWidget {
  const StaticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Static page')),
    );
  }
}
