import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/ui_widgets/swipe_card.dart';

class SwipingPage extends ConsumerStatefulWidget {
  const SwipingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SwipingPage> createState() => _SwipingPageState();
}

class _SwipingPageState extends ConsumerState<SwipingPage> {
  @override
  Widget build(BuildContext context) {
    return PullSwipeCard();
  }
}
