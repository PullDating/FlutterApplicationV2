import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

///returns a list of tuples that contain the valid values for the dating goals, the first item in the tuple is the
///database/api acceptable value, and the second value is the display value (pretty print string)
final validDatingGoalsProvider = StateNotifierProvider<ValidDatingGoalsNotifier, List<Tuple2<String,String>>>((ref) {
  return ValidDatingGoalsNotifier();
});

class ValidDatingGoalsNotifier extends StateNotifier<List<Tuple2<String,String>>> {
  ValidDatingGoalsNotifier() : super(
      <Tuple2<String,String>> [
        const Tuple2("longterm","Long-term Relationship"),
        const Tuple2("shortterm","Short-term Relationship"),
        const Tuple2("hookup","Hookup/Casual"),
        const Tuple2("marriage","Marriage"),
        const Tuple2("justchatting","Just Chatting"),
        const Tuple2("unsure","Unsure"),
      ]
  );
  void set(List<Tuple2<String,String>> value) {
    state = value;
  }
}