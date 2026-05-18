import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../domain/entities/home_section.dart';

final FutureProvider<List<HomeSection>> homeSectionsProvider =
    FutureProvider<List<HomeSection>>((Ref ref) {
  return ref.read(homeRepositoryProvider).getSections();
});
