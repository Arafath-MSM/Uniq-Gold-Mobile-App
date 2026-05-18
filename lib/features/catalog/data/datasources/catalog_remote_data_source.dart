import '../../../../core/config/endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/woo_category_model.dart';
import '../models/woo_product_model.dart';

class CatalogRemoteDataSource {
  CatalogRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<List<WooProductModel>> getProducts() async {
    try {
      final response = await _apiClient.dio.get<dynamic>(Endpoints.storeProducts);
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
        ),
        WooProductModel(
          id: 2,
          name: 'Gold Bangle Set',
          price: '359900',
          currencyCode: 'AED',
          currencyMinorUnit: 2,
          imageUrl: '',
          description: 'Starter mock item while API is not connected yet.',
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
      );
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
        WooCategoryModel(id: 1, name: 'Necklaces', imageUrl: ''),
        WooCategoryModel(id: 2, name: 'Rings', imageUrl: ''),
        WooCategoryModel(id: 3, name: 'Bangles', imageUrl: ''),
      ];
    }
  }
}
