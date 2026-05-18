import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/env.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_loader.dart';
import '../../../../shared/widgets/network_image_view.dart';
import '../controllers/catalog_controller.dart';

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(catalogCategoriesProvider);
    final productsAsync = ref.watch(catalogProductsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6DD),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'Connected base URL: ${Env.baseUrl}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          categoriesAsync.when(
            data: (categories) {
              return SizedBox(
                height: 52,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (BuildContext context, int index) {
                    final category = categories[index];
                    return Chip(label: Text(category.name));
                  },
                ),
              );
            },
            loading: () => const AppLoader(),
            error: (_, __) => const Text('Unable to load categories'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          productsAsync.when(
            data: (products) {
              return Column(
                children: products.map((product) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => context.push('/product/${product.id}'),
                      borderRadius: BorderRadius.circular(16),
                      child: Ink(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 88,
                              height: 88,
                              child: product.imageUrl.isEmpty
                                  ? const DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1E6C9),
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                      ),
                                      child: Icon(Icons.diamond_outlined),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: NetworkImageView(imageUrl: product.imageUrl),
                                    ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    Formatters.formatPriceLabel(
                                      product.price,
                                      minorUnit: product.currencyMinorUnit,
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const AppLoader(),
            error: (_, __) => const Text('Unable to load products'),
          ),
        ],
      ),
    );
  }
}
