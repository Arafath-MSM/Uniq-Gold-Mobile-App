import '../../domain/entities/woo_category.dart';
import '../../domain/entities/woo_product.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_remote_data_source.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl(this._remoteDataSource);

  final CatalogRemoteDataSource _remoteDataSource;

  @override
  Future<List<WooCategory>> getCategories() async {
    final categories = await _remoteDataSource.getCategories();
    return categories
        .map(
          (category) => WooCategory(
            id: category.id,
            name: category.name,
            imageUrl: category.imageUrl,
          ),
        )
        .toList();
  }

  @override
  Future<List<WooProduct>> getProducts() async {
    final products = await _remoteDataSource.getProducts();
    return products
        .map(
          (product) => WooProduct(
            id: product.id,
            name: product.name,
            price: product.price,
            currencyCode: product.currencyCode,
            currencyMinorUnit: product.currencyMinorUnit,
            imageUrl: product.imageUrl,
            description: product.description,
          ),
        )
        .toList();
  }

  @override
  Future<WooProduct> getProductById(String id) async {
    final product = await _remoteDataSource.getProductById(id);
    return WooProduct(
      id: product.id,
      name: product.name,
      price: product.price,
      currencyCode: product.currencyCode,
      currencyMinorUnit: product.currencyMinorUnit,
      imageUrl: product.imageUrl,
      description: product.description,
    );
  }
}
