import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/app_loader.dart';
import '../controllers/home_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionsAsync = ref.watch(homeSectionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Uniq Gold')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF221B10),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Uniq Gold',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Jewellery collections powered by your WooCommerce store.',
                  style: TextStyle(color: Color(0xFFF5E7B2)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          sectionsAsync.when(
            data: (sections) {
              return Column(
                children: sections.map((section) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      section.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const AppLoader(),
            error: (_, __) => const Text('Unable to load home sections'),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => context.go('/catalog'),
            child: const Text('Browse Catalog'),
          ),
        ],
      ),
    );
  }
}
