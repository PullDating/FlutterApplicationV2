import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/account_setup/dating_goal.dart';
import 'package:pull/providers/filters/valid_datingGoals.dart';
import 'package:pull/providers/filters/valid_genders.dart';
import 'package:tuple/tuple.dart';

class DatingGoalPage extends ConsumerStatefulWidget {
  const DatingGoalPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DatingGoalPage> createState() =>
      _ProfileDatingGoalFieldState();
}

class _ProfileDatingGoalFieldState extends ConsumerState<DatingGoalPage> {

  void changeRadioButton(String? value) {
    setState(() {
      if (value != null) {
        ref.read(accountCreationDatingGoalProvider.notifier).set(value);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String? datinggoal = ref.watch(accountCreationDatingGoalProvider);

    List<Tuple2<String,String>> validInputs = ref.watch(validDatingGoalsProvider);

    List<Widget> radioTiles = [];
    for(int i = 0; i < validInputs.length; i++){
      radioTiles.add(
          RadioListTile<String>(
            title: Text(validInputs[i].item2),
            value: validInputs[i].item1,
            groupValue: datinggoal,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          )
      );
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: radioTiles,
      ),
    );
  }
}

