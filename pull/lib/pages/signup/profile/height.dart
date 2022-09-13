import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/account_setup/height.dart';
import 'package:pull/providers/filters/height_max.dart';
import 'package:pull/providers/filters/height_min.dart';

class HeightPage extends ConsumerStatefulWidget {
  const HeightPage({Key? key}) : super(key: key);

  @override
  ConsumerState<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends ConsumerState<HeightPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int height = ref.watch(accountCreationHeightProvider);
    int? feet;
    int? inches;

    List<int> result = cmToFootAndInch(height);
    feet = result[0];
    inches = result[1];

    return SizedBox(
        width: double.infinity,
        height: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$feet\' ${(inches < 10) ? '0' : ''}$inches\""),
            RotatedBox(
              quarterTurns: 3,
              child: Slider(
                min: ref.watch(minHeightProvider).toDouble(),
                max: ref.watch(maxHeightProvider).toDouble(),
                divisions: ref.watch(maxHeightProvider) - ref.watch(minHeightProvider),
                value: height.toDouble(),
                onChanged: (value) {
                  setState(() {
                    ref.read(accountCreationHeightProvider.notifier).set(value.toInt());
                  });
                },
              ),
            ),
            Text(
                '${(height < 100) ? '0' : ''}${height.toStringAsFixed(1)} cm'),
          ],
        ));
  }
}

///This function takes in the height of the person in cm, and returns their height
///in feet and inches, as a list where the first item is the feet and the second
/// in inches. both integers.
List<int> cmToFootAndInch(int height) {
  int feet = (height ~/ 30.48).toInt();
  int inches = (((height / 30.48) - feet) * 12).toInt();
  return [feet,inches];
}