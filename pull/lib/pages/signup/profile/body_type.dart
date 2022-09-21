import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/account_setup/body_type.dart';
import 'package:pull/providers/filters/valid_bodyTypes.dart';
import 'package:tuple/tuple.dart';

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

    List<Tuple2<String,String>> validInputs = ref.watch(validBodyTypesProvider);

    List<Widget> radioTiles = [];
    for(int i = 0; i < validInputs.length; i++){
      radioTiles.add(
        RadioListTile<String>(
          title: Text(validInputs[i].item2),
          value: validInputs[i].item1,
          groupValue: bodytype,
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