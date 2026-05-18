import '../entities/home_section.dart';
import '../repositories/home_repository.dart';

class GetHomeSections {
  GetHomeSections(this._repository);

  final HomeRepository _repository;

  Future<List<HomeSection>> call() {
    return _repository.getSections();
  }
}
