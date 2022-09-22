import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/filter.dart';
import 'package:pull/providers/account_setup/filters.dart';
import 'package:pull/providers/filters/age_max.dart';
import 'package:pull/providers/filters/age_min.dart';
import 'package:pull/providers/filters/distance_max.dart';
import 'package:pull/providers/filters/height_max.dart';
import 'package:pull/providers/filters/height_min.dart';
import 'package:pull/ui_widgets/filter_list.dart';

class FilterPage extends ConsumerStatefulWidget {
  FilterPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends ConsumerState<FilterPage> {

  @override
  void initState() {
    super.initState();
  }

  _ageChanged(int min, int max){
    setState(() {
      ref.read(accountCreationFilterProvider).copyWith(minAge: min);
      ref.read(accountCreationFilterProvider).copyWith(maxAge: max);
    });
  }

  _heightChanged(int min, int max){
    setState(() {

      ref.read(accountCreationFilterProvider).copyWith(minHeight: min);
      ref.read(accountCreationFilterProvider).copyWith(maxHeight: max);
    });
  }

  _maxDistanceChanged(int value){
    setState(() {
      ref.read(accountCreationFilterProvider).copyWith(maxDistance: value);
    });
  }

  _womenChecked(){
    setState(() {
      ref.read(accountCreationFilterProvider).copyWith(genderWoman: !ref.read(accountCreationFilterProvider).genderWoman);
    });
  }

  _menChecked(){
    setState(() {
      ref.read(accountCreationFilterProvider).copyWith(genderMan: !ref.read(accountCreationFilterProvider).genderMan);
    });
  }

  _nonBinaryChecked() {
    setState(() {
      ref.read(accountCreationFilterProvider).copyWith(genderNonBinary: !ref.read(accountCreationFilterProvider).genderNonBinary);
    });
  }

  _obeseChecked(){
    setState(() {
      ref.read(accountCreationFilterProvider).copyWith(btObese: !ref.read(accountCreationFilterProvider).btObese);
    });
  }

  _heavyChecked(){
    setState(() {
      ref.read(accountCreationFilterProvider).copyWith(btHeavy: !ref.read(accountCreationFilterProvider).btHeavy);
    });
  }

  _muscularChecked(){
    setState(() {
      ref.read(accountCreationFilterProvider).copyWith(btMuscular: !ref.read(accountCreationFilterProvider).btMuscular);
    });
  }

  _averageChecked(){
    setState(() {
      ref.read(accountCreationFilterProvider).copyWith(btAverage: !ref.read(accountCreationFilterProvider).btAverage);
    });
  }

  _leanChecked(){
    setState(() {
      ref.read(accountCreationFilterProvider).copyWith(btLean: !ref.read(accountCreationFilterProvider).btLean);
    });

  }

  @override
  Widget build(BuildContext context) {

    return FilterList(
      displayFilter: ref.watch(accountCreationFilterProvider)!,
      ageChanged: (min, max) => _ageChanged(min, max),
      heightChanged: (min, max) => _heightChanged(min, max),
      maxDistanceChanged: (value) => _maxDistanceChanged(value),
      womenChecked: () => _womenChecked(),
      menChecked: () => _menChecked(),
      nonBinaryChecked: () => _nonBinaryChecked(),
      obeseChecked: () => _obeseChecked(),
      heavyChecked: () => _heavyChecked(),
      muscularChecked: () => _muscularChecked(),
      averageChecked: () => _averageChecked(),
      leanChecked: () => _leanChecked(),
    );
  }
}