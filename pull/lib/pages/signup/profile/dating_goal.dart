import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/account_setup/dating_goal.dart';

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

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RadioListTile<String>(
            title: const Text('Marriage'),
            value: 'marriage',
            groupValue: datinggoal,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
          RadioListTile<String>(
            title: const Text('Long-term Relationship'),
            value: 'longterm',
            groupValue: datinggoal,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
          RadioListTile<String>(
            title: const Text('Short-term Relationship'),
            value: 'shortterm',
            groupValue: datinggoal,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
          RadioListTile<String>(
            title: const Text('Hookup'),
            value: 'hookup',
            groupValue: datinggoal,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
          RadioListTile<String>(
            title: const Text('Just Chatting'),
            value: 'justchatting',
            groupValue: datinggoal,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
          RadioListTile<String>(
            title: const Text('Figuring out what I want'),
            value: 'unsure',
            groupValue: datinggoal,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
        ],
      ),
    );
  }
}

