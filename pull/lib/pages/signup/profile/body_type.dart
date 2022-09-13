import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/account_setup/body_type.dart';

class BodyTypePage extends ConsumerStatefulWidget {
  const BodyTypePage({Key? key}) : super(key: key);

  @override
  ConsumerState<BodyTypePage> createState() =>
      _BodyTypePageState();
}

class _BodyTypePageState extends ConsumerState<BodyTypePage> {

  void changeRadioButton(String? value) {
    setState(() {
      if (value != null) {
        ref.read(accountCreationBodyTypeProvider.notifier).set(value);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String? bodytype = ref.watch(accountCreationBodyTypeProvider);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RadioListTile<String>(
            title: const Text('Obese'),
            value: 'obese',
            groupValue: bodytype,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
          RadioListTile<String>(
            title: const Text('Heavy'),
            value: 'heavy',
            groupValue: bodytype,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
          RadioListTile<String>(
            title: const Text('Muscular'),
            value: 'muscular',
            groupValue: bodytype,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
          RadioListTile<String>(
            title: const Text('Average'),
            value: 'average',
            groupValue: bodytype,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
          RadioListTile<String>(
            title: const Text('Lean'),
            value: 'lean',
            groupValue: bodytype,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          ),
        ],
      ),
    );
  }
}