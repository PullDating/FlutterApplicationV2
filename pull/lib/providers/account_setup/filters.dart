import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/filter.dart';
import 'package:pull/providers/filters/age_max.dart';
import 'package:pull/providers/filters/age_min.dart';
import 'package:pull/providers/filters/distance_max.dart';
import 'package:pull/providers/filters/height_max.dart';
import 'package:pull/providers/filters/height_min.dart';

///returns the filters from the account creation
final accountCreationFilterProvider = StateNotifierProvider<AccountCreationFilterNotifier, Filter>((ref) {
  return AccountCreationFilterNotifier(ref);
});

class AccountCreationFilterNotifier extends StateNotifier<Filter>{

  //the inital value should simply be the most permissive filters.
  AccountCreationFilterNotifier(ref) : super(Filter(
    btObese: true,
    btHeavy: true,
    btMuscular: true,
    btAverage: true,
    btLean: true,
    genderMan: true,
    genderNonBinary: true,
    genderWoman: true,
    maxAge: ref.read(maxAgeProvider),
    minAge: ref.read(minAgeProvider),
    maxDistance: ref.read(maxDistanceProvider),
    maxHeight: ref.read(maxHeightProvider),
    minHeight: ref.read(minHeightProvider),
  ));
  void set(Filter value) {
    state = value;
  }
}