import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

///returns a list of tuples that contain the valid values for the bodytypes, the first item in the tuple is the
///database/api acceptable value, and the second value is the display value (pretty print string)
final validBodyTypesProvider = StateNotifierProvider<ValidBodyTypesNotifier, List<Tuple2<String,String>>>((ref) {
  return ValidBodyTypesNotifier();
});

class ValidBodyTypesNotifier extends StateNotifier<List<Tuple2<String,String>>> {
  ValidBodyTypesNotifier() : super(
    <Tuple2<String,String>> [
      const Tuple2("lean","Lean"),
      const Tuple2("average","Average"),
      const Tuple2("muscular","Muscular"),
      const Tuple2("heavy","Heavy"),
      const Tuple2("obese","Obese"),
    ]
  );
  void set(List<Tuple2<String,String>> value) {
    state = value;
  }
}