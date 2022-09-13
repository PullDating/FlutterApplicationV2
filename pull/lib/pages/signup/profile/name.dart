import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/account_setup/name.dart';

class NamePage extends ConsumerStatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  ConsumerState<NamePage> createState() => _NamePageState();
}

class _NamePageState extends ConsumerState<NamePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String? initial = ref.read(accountCreationNameProvider);
    _nameController.text = (initial == null) ? '' : initial;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: Container(
              //width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      onChanged: (text) {
                        ref.read(accountCreationNameProvider.notifier).set(text);
                      },
                    ),
                  ],
                )),
          ),
        );
      }
    );
  }
}
