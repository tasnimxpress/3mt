import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/queries/category_queries.dart';
import '../models/category.dart';

final categoriesProvider = FutureProvider.family<List<Category>, String>(
  (ref, type) async {
    return CategoryQueries.getByType(type);
  },
);
