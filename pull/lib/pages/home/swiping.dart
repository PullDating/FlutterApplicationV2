import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/person.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/network/pull_api/repository.dart';
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

  //ignore index, it is not used by us
  _preSwipeCheck(int index, SwipeDirection direction){
    print("pre swipe callback:");
    print("index: $index, direction: $direction");
    switch (direction) {
      case SwipeDirection.left:
      case SwipeDirection.right:
        return true;
      case SwipeDirection.up:
      case SwipeDirection.down:
        return false;
    }
  }

//ignore index, it is not used by us
  _swipeCompleted(int index, SwipeDirection direction){
    print("swipe complete callback:");
    PullRepository repo = PullRepository(ref.read);
    if(direction == SwipeDirection.left){
      //dislike
      repo.dislike(ref.read(peopleProvider)[0].uuid);
    }else if (direction == SwipeDirection.right) {
      //like
      repo.like(ref.read(peopleProvider)[0].uuid);
    }
    ref.read(peopleProvider.notifier).remove();
  }

  @override
  Widget build(BuildContext context) {

    List<Person> peopleList = ref.watch(peopleProvider);

    print("Current order of people list:");
    for(int i = 0 ; i < peopleList.length;i++){
      print(peopleList[i].uuid);
    }

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

          // Stack peopleStack = Stack(
          //   children: [
          //     PullSwipeCard(person: peopleList[0]!, key: UniqueKey(),),
          //     //(peopleList.length > 1)? PullSwipeCard(person: peopleList[1], key: Key("PullSwipeCard:${peopleList[1].uuid}"),) : Container(),
          //   ],
          // );

          return PullSwipeCard(person: peopleList[0],);
        },
      ) : Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
