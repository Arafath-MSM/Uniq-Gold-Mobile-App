import '../../../../core/network/api_client.dart';
import '../models/home_section_model.dart';

class HomeRemoteDataSource {
  HomeRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<List<HomeSectionModel>> getSections() async {
    try {
      await _apiClient.dio.get<dynamic>('/wp-json/uniqgold/v1/home');
    } catch (_) {
      return <HomeSectionModel>[
        HomeSectionModel(title: 'Featured Collections'),
        HomeSectionModel(title: 'Best Sellers'),
        HomeSectionModel(title: 'Today Gold Rate'),
      ];
    }

    return <HomeSectionModel>[
      HomeSectionModel(title: 'Featured Collections'),
    ];
  }
}
