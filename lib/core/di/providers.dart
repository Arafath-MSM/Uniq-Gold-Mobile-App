import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/api_client.dart';
import '../storage/local_storage_service.dart';
import '../storage/secure_storage_service.dart';
import '../../features/catalog/data/datasources/catalog_remote_data_source.dart';
import '../../features/catalog/data/repositories/catalog_repository_impl.dart';
import '../../features/catalog/domain/repositories/catalog_repository.dart';
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';

final Provider<SecureStorageService> secureStorageServiceProvider =
    Provider<SecureStorageService>((Ref ref) {
  return SecureStorageService();
});

final Provider<LocalStorageService> localStorageServiceProvider =
    Provider<LocalStorageService>((Ref ref) {
  return LocalStorageService();
});

final Provider<ApiClient> apiClientProvider = Provider<ApiClient>((Ref ref) {
  return ApiClient(
    secureStorageService: ref.read(secureStorageServiceProvider),
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

final Provider<HomeRemoteDataSource> homeRemoteDataSourceProvider =
    Provider<HomeRemoteDataSource>((Ref ref) {
  return HomeRemoteDataSource(ref.read(apiClientProvider));
});

final Provider<HomeRepository> homeRepositoryProvider =
    Provider<HomeRepository>((Ref ref) {
  return HomeRepositoryImpl(ref.read(homeRemoteDataSourceProvider));
});

final Provider<CatalogRemoteDataSource> catalogRemoteDataSourceProvider =
    Provider<CatalogRemoteDataSource>((Ref ref) {
  return CatalogRemoteDataSource(ref.read(apiClientProvider));
});

final Provider<CatalogRepository> catalogRepositoryProvider =
    Provider<CatalogRepository>((Ref ref) {
  return CatalogRepositoryImpl(ref.read(catalogRemoteDataSourceProvider));
});
