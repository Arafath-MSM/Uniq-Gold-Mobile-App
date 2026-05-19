import '../entities/woo_category.dart';
import '../entities/woo_product.dart';

abstract class CatalogRepository {
  Future<List<WooCategory>> getCategories();
  Future<List<WooProduct>> getProducts();
  Future<WooProduct> getProductById(String id);
  Future<List<WooProduct>> searchProducts(String query);
}
