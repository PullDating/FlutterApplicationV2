import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/account_setup/gender.dart';

class GenderPage extends ConsumerStatefulWidget {
  const GenderPage({Key? key}) : super(key: key);

  @override
  ConsumerState<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends ConsumerState<GenderPage> {

  void changeRadioButton(String? value) {
    print("gender radio button pressed");
    setState(() {
      if(value != null){
        ref.read(accountCreationGenderProvider.notifier).set(value);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String? gender = ref.watch(accountCreationGenderProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RadioListTile<String>(
          title: const Text('Man'),
          value: 'man',
          groupValue: gender,
          onChanged: (String? value) {
            changeRadioButton(value);
          },
        ),
        RadioListTile<String>(
          title: const Text('Woman'),
          value: 'woman',
          groupValue: gender,
          onChanged: (String? value) {
            changeRadioButton(value);
          },
        ),
        RadioListTile<String>(
          title: const Text('Non-Binary'),
          value: 'non-binary',
          groupValue: gender,
          onChanged: (String? value) {
            changeRadioButton(value);
          },
        ),
      ],
    );
  }
}