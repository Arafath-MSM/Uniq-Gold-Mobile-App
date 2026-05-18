import '../../domain/entities/home_section.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<List<HomeSection>> getSections() async {
    final sections = await _remoteDataSource.getSections();
    return sections
        .map((section) => HomeSection(title: section.title))
        .toList();
  }
}
