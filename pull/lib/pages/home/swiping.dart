import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/person.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/providers/swiping/peopleProvider.dart';
import 'package:pull/providers/swiping/people_count_target.dart';
import 'package:pull/ui_widgets/swipe_card.dart';
import 'package:swipable_stack/swipable_stack.dart';

class SwipingPage extends ConsumerStatefulWidget {
  const SwipingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SwipingPage> createState() => _SwipingPageState();
}

class _SwipingPageState extends ConsumerState<SwipingPage> {

  ///controls the swipable stack
  late final SwipableStackController _controller;

  void _listenController() {
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);


    print("\n\nAttempting to get people for the swiping page");
    //should go and get people if there are none (or a low number) of people in queue.
    if(ref.read(peopleProvider).length < ref.read(peopleCountTargetProvider)){
      ref.read(peopleProvider.notifier).add(ref.read(peopleCountTargetProvider) - ref.read(peopleProvider).length);
    }

  }

  @override
  void dispose(){
    super.dispose();
    _controller..removeListener(_listenController)..dispose();
  }

  _preSwipeCheck(int index, SwipeDirection direction){
    print("pre swipe callback:");
    print("index: $index, direction: $direction");
  }

  _swipeCompleted(int index, SwipeDirection direction){
    print("swipe complete callback:");
    print("index: $index, direction: $direction");
  }

  @override
  Widget build(BuildContext context) {

    List<Person> peopleList = ref.watch(peopleProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (peopleList.isNotEmpty)? SwipableStack(
        hitTestBehavior: HitTestBehavior.deferToChild,
        controller: _controller,
        stackClipBehaviour: Clip.none,
        allowVerticalSwipe: false,
        //runs before to see if the swipe needs to be abandonded.
        onWillMoveNext: (index, direction) => _preSwipeCheck(index, direction),
        onSwipeCompleted: (index, direction) => _swipeCompleted(index,direction),
        horizontalSwipeThreshold: 0.85,
        verticalSwipeThreshold: 1.0,
        builder: (BuildContext context, properties) {
          return PullSwipeCard(person: peopleList[0]);
        },
      ) : Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
