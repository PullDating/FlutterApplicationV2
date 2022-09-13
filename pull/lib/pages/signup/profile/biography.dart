import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull/providers/max_biography_characters.dart';

import '../../../providers/account_setup/biography.dart';

class BiographyPage extends ConsumerStatefulWidget {
  const BiographyPage({Key? key}) : super(key: key);

  @override
  ConsumerState<BiographyPage> createState() =>
      _BiographyPageState();
}

class _BiographyPageState extends ConsumerState<BiographyPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _controller.text = (ref.watch(accountCreationBiographyProvider) == null) ? '' : ref.watch(accountCreationBiographyProvider)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        return FractionallySizedBox(
          widthFactor: 0.85,
          child: Container(
            child: Column(
              children: [
                TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(ref.watch(maxBiographyLengthProvider)),
                  ],
                  minLines: 1,
                  maxLines: 5,
                  obscureText: false,
                  controller: _controller,
                  onChanged: (String value) {
                    setState(() {
                      ref.read(accountCreationBiographyProvider.notifier).set(value);
                    });
                  },
                ),
                Text(
                  (_controller.text.characters.length >= ref.watch(maxBiographyLengthProvider))
                      ? "Max Characters Reached!"
                      : "${_controller.text.characters.length}/${ref.watch(maxBiographyLengthProvider)}",
                  style: TextStyle(
                    color:
                    (_controller.text.characters.length >= ref.watch(maxBiographyLengthProvider)) ? Theme.of(context).colorScheme.secondary : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
