import '../../../../core/config/endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/woo_category_model.dart';
import '../models/woo_product_model.dart';

class CatalogRemoteDataSource {
  CatalogRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<List<WooProductModel>> getProducts() async {
    try {
      final response = await _apiClient.dio.get<dynamic>(
        Endpoints.storeProducts,
        queryParameters: <String, dynamic>{
          'orderby': 'date',
          'order': 'desc',
          'per_page': 20,
        },
      );
      final List<dynamic> data = response.data as List<dynamic>? ?? <dynamic>[];
      return data
          .map((dynamic item) => WooProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return <WooProductModel>[
        WooProductModel(
          id: 1,
          name: '22K Gold Necklace',
          price: '489900',
          currencyCode: 'AED',
          currencyMinorUnit: 2,
          imageUrl: '',
          description: 'Elegant necklace placeholder from WooCommerce catalog.',
          categorySlugs: const <String>['necklaces'],
        ),
        WooProductModel(
          id: 2,
          name: 'Gold Bangle Set',
          price: '359900',
          currencyCode: 'AED',
          currencyMinorUnit: 2,
          imageUrl: '',
          description: 'Starter mock item while API is not connected yet.',
          categorySlugs: const <String>['bracelets'],
        ),
      ];
    }
  }

  Future<WooProductModel> getProductById(String id) async {
    try {
      final response =
          await _apiClient.dio.get<dynamic>(Endpoints.storeProductById(id));
      return WooProductModel.fromJson(response.data as Map<String, dynamic>);
    } catch (_) {
      return WooProductModel(
        id: int.tryParse(id) ?? 0,
        name: 'Uniq Gold Product',
        price: '489900',
        currencyCode: 'AED',
        currencyMinorUnit: 2,
        imageUrl: '',
        description: 'Live product details will appear here once the WooCommerce API responds.',
        categorySlugs: const <String>[],
      );
    }
  }

  Future<List<WooProductModel>> searchProducts(String query) async {
    final String normalized = query.trim();
    if (normalized.isEmpty) {
      return <WooProductModel>[];
    }

    try {
      final response = await _apiClient.dio.get<dynamic>(
        Endpoints.storeProducts,
        queryParameters: <String, dynamic>{
          'search': normalized,
          'orderby': 'date',
          'order': 'desc',
          'per_page': 12,
        },
      );
      final List<dynamic> data = response.data as List<dynamic>? ?? <dynamic>[];
      return data
          .map((dynamic item) => WooProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      final products = await getProducts();
      final lower = normalized.toLowerCase();
      return products.where((WooProductModel product) {
        return product.name.toLowerCase().contains(lower);
      }).toList();
    }
  }

  Future<List<WooCategoryModel>> getCategories() async {
    try {
      final response =
          await _apiClient.dio.get<dynamic>(Endpoints.storeCategories);
      final List<dynamic> data = response.data as List<dynamic>? ?? <dynamic>[];
      return data
          .map((dynamic item) => WooCategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return <WooCategoryModel>[
        WooCategoryModel(id: 1, name: 'Necklaces', slug: 'necklaces', imageUrl: ''),
        WooCategoryModel(id: 2, name: 'Rings', slug: 'rings', imageUrl: ''),
        WooCategoryModel(id: 3, name: 'Bracelets', slug: 'braclets', imageUrl: ''),
        WooCategoryModel(id: 4, name: 'Earrings', slug: 'earrings', imageUrl: ''),
      ];
    }
  }
}
