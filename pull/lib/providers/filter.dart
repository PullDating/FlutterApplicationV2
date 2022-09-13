import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/filter.dart';

///returns the user's filters
final filterProvider = StateNotifierProvider<FilterNotifier, Filter?>((ref) {
  return FilterNotifier();
});

class FilterNotifier extends StateNotifier<Filter?> {
  FilterNotifier() : super(null);
  void set(Filter value) {
    state = value;
  }
}