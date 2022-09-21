import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/account_setup/gender.dart';
import 'package:pull/providers/filters/valid_genders.dart';
import 'package:tuple/tuple.dart';

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

    List<Tuple2<String,String>> validInputs = ref.watch(validGendersProvider);

    List<Widget> radioTiles = [];
    for(int i = 0; i < validInputs.length; i++){
      radioTiles.add(
          RadioListTile<String>(
            title: Text(validInputs[i].item2),
            value: validInputs[i].item1,
            groupValue: gender,
            onChanged: (String? value) {
              changeRadioButton(value);
            },
          )
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: radioTiles,
    );
  }
}