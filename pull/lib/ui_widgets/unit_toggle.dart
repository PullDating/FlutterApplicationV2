import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/unit_system.dart';

class UnitToggle extends ConsumerWidget {
  const UnitToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Text("Metric"),
        Switch(value: ref.watch(unitSystemProvider), onChanged: (value) {
          ref.read(unitSystemProvider.notifier).set(!ref.read(unitSystemProvider));
        },
          activeColor: Colors.pinkAccent,
          inactiveTrackColor: Color.fromRGBO(38, 38, 38, 0.4),
          activeTrackColor: Color.fromRGBO(38, 38, 38, 0.4),
          inactiveThumbColor: Colors.blue,
        ),
        const Text("Imperial")
      ],
    );
  }
}
