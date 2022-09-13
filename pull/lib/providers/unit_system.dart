import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns a boolean indicating whether to use the metric system [True] or imperial [False]
final unitSystemProvider = StateNotifierProvider<UnitSystemNotifier, bool>((ref) {
  return UnitSystemNotifier();
});

class UnitSystemNotifier extends StateNotifier<bool> {
  UnitSystemNotifier() : super(true);
  void set(bool value) {
    state = value;
  }
}