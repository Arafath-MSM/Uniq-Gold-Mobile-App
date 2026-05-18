import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../domain/entities/woo_category.dart';
import '../../domain/entities/woo_product.dart';

final FutureProvider<List<WooProduct>> catalogProductsProvider =
    FutureProvider<List<WooProduct>>((Ref ref) {
  return ref.read(catalogRepositoryProvider).getProducts();
});

final FutureProvider<List<WooCategory>> catalogCategoriesProvider =
    FutureProvider<List<WooCategory>>((Ref ref) {
  return ref.read(catalogRepositoryProvider).getCategories();
});

final productDetailsProvider =
    FutureProvider.family<WooProduct, String>((Ref ref, String productId) {
  return ref.read(catalogRepositoryProvider).getProductById(productId);
});
