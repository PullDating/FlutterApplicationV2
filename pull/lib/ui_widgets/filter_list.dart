import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/filter.dart';
import 'package:pull/providers/filters/age_max.dart';
import 'package:pull/providers/filters/age_min.dart';
import 'package:pull/providers/filters/distance_max.dart';
import 'package:pull/providers/filters/height_max.dart';
import 'package:pull/providers/filters/height_min.dart';
import 'package:pull/providers/unit_system.dart';
import 'package:pull/ui_widgets/toggle_button.dart';
import 'package:pull/ui_widgets/unit_toggle.dart';

///a UI element for displaying list of filters that can be edited.
class FilterList extends ConsumerWidget {
  const FilterList(
      {Key? key,
      required this.displayFilter,
      required this.menChecked,
      required this.womenChecked,
      required this.nonBinaryChecked,
      required this.ageChanged,
      required this.maxDistanceChanged,
      required this.heightChanged,
      required this.obeseChecked,
      required this.heavyChecked,
      required this.muscularChecked,
      required this.averageChecked,
      required this.leanChecked,
      })
      : super(key: key);

  ///the filter object that the list is representing
  final Filter displayFilter;
  final Function() menChecked;
  final Function() womenChecked;
  final Function() nonBinaryChecked;
  final Function(int, int) ageChanged;
  final Function(int) maxDistanceChanged;
  final Function(int, int) heightChanged;
  final Function() obeseChecked;
  final Function() heavyChecked;
  final Function() muscularChecked;
  final Function() averageChecked;
  final Function() leanChecked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.9,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                FilterListItem(
                    icon: Icon(Icons.transgender),
                    title: "Gender(s)",
                    widget: Row(
                      children: [
                        SizedBox(
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: PullToggleButton(
                              onToggle: () => menChecked(),
                              pressed: (displayFilter.genderMan),
                              text: "Men",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: PullToggleButton(
                              onToggle: () => womenChecked(),
                              pressed: (displayFilter.genderWoman),
                              text: "Women",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: PullToggleButton(
                              onToggle: () => nonBinaryChecked(),
                              pressed: (displayFilter.genderNonBinary),
                              text: "Non-Binary",
                            ),
                          ),
                        ),
                      ],
                    )),
                FilterListItem(
                    icon: Icon(Icons.access_time_outlined),
                    title: "Age",
                    widget: SizedBox(
                      width: 280,
                      child: RangeSlider(
                        min: ref.watch(minAgeProvider).toDouble(),
                        max: ref.watch(maxAgeProvider).toDouble(),
                        divisions:
                            ref.watch(maxAgeProvider) - ref.watch(minAgeProvider),
                        values: RangeValues(displayFilter.minAge.toDouble(),
                            displayFilter.maxAge.toDouble()),
                        onChanged: (values) {
                          ageChanged(values.start.toInt(), values.end.toInt());
                        },
                        labels: RangeLabels(
                            displayFilter.minAge.round().toString(),
                            displayFilter.maxAge.round().toString()),
                      ),
                    )),
                FilterListItem(
                    icon: Icon(Icons.social_distance),
                    title: "Distance",
                    widget: SizedBox(
                      width: 280,
                      child: Slider(
                        min: 0,
                        max: ref.watch(maxDistanceProvider).toDouble(),
                        divisions: ref.watch(maxDistanceProvider),
                        value: displayFilter.maxDistance.toDouble(),
                        onChanged: (value) {
                          maxDistanceChanged(value.toInt());
                        },
                        label: (ref.watch(unitSystemProvider))
                            ? "${displayFilter.maxDistance.round().toString()} km"
                            : "${(displayFilter.maxDistance * 0.621371).round().toString()} miles",
                      ),
                    )),
                FilterListItem(
                    icon: Icon(Icons.height),
                    title: "Height",
                    widget: SizedBox(
                      width: 280,
                      child: RangeSlider(
                        min: ref.watch(minHeightProvider).toDouble(),
                        max: ref.watch(maxHeightProvider).toDouble(),
                        divisions: ref.watch(maxHeightProvider) -
                            ref.watch(minHeightProvider),
                        values: RangeValues(displayFilter.minHeight.toDouble(),
                            displayFilter.maxHeight.toDouble()),
                        onChanged: (values) {
                          heightChanged(
                              values.start.toInt(), values.end.toInt());
                        },
                        labels: RangeLabels(
                            (ref.watch(unitSystemProvider))
                                ? "${displayFilter.minHeight.round()} cm"
                                : "${(displayFilter.minHeight ~/ 30.48).round().toString()}\'${(((displayFilter.minHeight / 30.48) - (displayFilter.minHeight ~/ 30.48)) * 12).toInt().toString()}\"",
                            (ref.watch(unitSystemProvider))
                                ? "${displayFilter.maxHeight.round()} cm"
                                : "${(displayFilter.maxHeight ~/ 30.48).round().toString()}\'${(((displayFilter.maxHeight / 30.48) - (displayFilter.maxHeight ~/ 30.48)) * 12).toInt().toString()}\""),
                      ),
                    )),
                FilterListItem(
                    icon: Icon(Icons.man_outlined),
                    title: "BodyType",
                    widget: Flexible(
                      flex: 5,
                      child: Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        children: [
                          SizedBox(
                            height: 30,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: PullToggleButton(
                                onToggle: () => obeseChecked(),
                                text: "Obese",
                                pressed: displayFilter.btObese,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: PullToggleButton(
                                onToggle: () => heavyChecked(),
                                text: "Heavy",
                                pressed: displayFilter.btHeavy,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: PullToggleButton(
                                onToggle: () => muscularChecked(),
                                text: "Muscular",
                                pressed: displayFilter.btMuscular,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: PullToggleButton(
                                onToggle: () => averageChecked(),
                                text: "Average",
                                pressed: displayFilter.btAverage,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: PullToggleButton(
                                onToggle: () => leanChecked(),
                                text: "Lean",
                                pressed: displayFilter.btLean,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Container(
            height: constraints.maxHeight*0.1,
            color: Colors.lightBlueAccent,
            child: const UnitToggle(),
          )
        ],
      );
    });
  }
}

class FilterListItem extends StatelessWidget {
  final Icon icon;
  final Widget widget;
  String? title;

  FilterListItem({
    Key? key,
    required this.icon,
    required this.widget,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Container(
              width: 10,
            ),
            (title != null) ? Text(title!) : Text(''),
            Spacer(),
            widget,
          ],
        ),
      ),
    );
  }
}
