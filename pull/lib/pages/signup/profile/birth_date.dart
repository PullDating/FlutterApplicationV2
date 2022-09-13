import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart' show CupertinoDatePicker, CupertinoDatePickerMode;
import 'package:pull/providers/account_setup/birthdate.dart';

class BirthDatePage extends ConsumerStatefulWidget {
  const BirthDatePage({Key? key}) : super(key: key);

  @override
  ConsumerState<BirthDatePage> createState() =>
      _BirthDateFieldPage();
}

class _BirthDateFieldPage extends ConsumerState<BirthDatePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    DateTime? birthdate;
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: (birthdate == null) ? DateTime.now() : birthdate,
          onDateTimeChanged: (val) {
            birthdate = val;
            ref.read(accountCreationBirthDateProvider.notifier).set(birthdate!);
          }),
    );
  }
}