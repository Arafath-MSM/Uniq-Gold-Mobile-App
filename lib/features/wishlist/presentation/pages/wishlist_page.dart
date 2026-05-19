import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_loader.dart';
import '../../../../shared/widgets/network_image_view.dart';
import '../../../catalog/presentation/controllers/catalog_controller.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(catalogProductsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F5),
      appBar: AppBar(
        title: const Text('Wishlist'),
        backgroundColor: Colors.white,
      ),
      body: productsAsync.when(
        data: (products) {
          final wishlistItems = products.take(4).toList();
          if (wishlistItems.isEmpty) {
            return const _WishlistEmptyView();
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              const Text(
                'Saved Pieces',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                'A refined shortlist of products you may want to revisit.',
                style: TextStyle(color: AppColors.textMuted, height: 1.5),
              ),
              const SizedBox(height: 18),
              ...wishlistItems.map((product) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: SizedBox(
                          width: 92,
                          height: 92,
                          child: product.imageUrl.isEmpty
                              ? Container(
                                  color: const Color(0xFFF2E9D7),
                                  child: const Icon(Icons.diamond_outlined),
                                )
                              : NetworkImageView(imageUrl: product.imageUrl),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              Formatters.formatPriceLabel(
                                product.price,
                                minorUnit: product.currencyMinorUnit,
                              ),
                              style: const TextStyle(
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () => context.push('/product/${product.id}'),
                                    child: const Text('View'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Color(0xFFE35C56),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (_, __) => const Center(
          child: Text('Unable to load wishlist'),
        ),
      ),
    );
  }
}

class _WishlistEmptyView extends StatelessWidget {
  const _WishlistEmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                color: Color(0xFFF2E9D7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 34,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Your wishlist is empty',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Save your favorite rings, necklaces, bracelets, and earrings here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted, height: 1.5),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () => context.go('/catalog'),
              child: const Text('Browse Catalog'),
            ),
          ],
        ),
      ),
    );
  }
}
