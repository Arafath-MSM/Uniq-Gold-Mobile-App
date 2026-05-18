import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../catalog/presentation/controllers/catalog_controller.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_loader.dart';
import '../../../../shared/widgets/network_image_view.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailsProvider(productId));

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: productAsync.when(
        loading: () => const AppLoader(),
        error: (_, __) => const Center(
          child: Text('Unable to load product details'),
        ),
        data: (product) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              SizedBox(
                height: 280,
                child: product.imageUrl.isEmpty
                    ? DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1E6C9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Icon(Icons.diamond_outlined, size: 52),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: NetworkImageView(imageUrl: product.imageUrl),
                      ),
              ),
              const SizedBox(height: 16),
              Text(
                product.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                Formatters.formatPriceLabel(
                  product.price,
                  minorUnit: product.currencyMinorUnit,
                ),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Text(
                _stripHtml(product.description),
                style: const TextStyle(height: 1.5),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {},
                child: const Text('Add to Cart'),
              ),
            ],
          );
        },
      ),
    );
  }

  String _stripHtml(String input) {
    return input
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll('&nbsp;', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
