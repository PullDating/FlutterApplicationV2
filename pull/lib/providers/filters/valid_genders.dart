import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

///returns a list of tuples that contain the valid values for the genders, the first item in the tuple is the
///database/api acceptable value, and the second value is the display value (pretty print string)
final validGendersProvider = StateNotifierProvider<ValidGendersNotifier, List<Tuple2<String,String>>>((ref) {
  return ValidGendersNotifier();
});

class ValidGendersNotifier extends StateNotifier<List<Tuple2<String,String>>> {
  ValidGendersNotifier() : super(
      <Tuple2<String,String>> [
        const Tuple2("man","Man"),
        const Tuple2("woman","Woman"),
        const Tuple2("non-binary","Non-Binary"),
      ]
  );
  void set(List<Tuple2<String,String>> value) {
    state = value;
  }
}