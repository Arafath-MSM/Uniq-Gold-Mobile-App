import '../entities/home_section.dart';

abstract class HomeRepository {
  Future<List<HomeSection>> getSections();
}
