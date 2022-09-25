import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:pull/models/person.dart';
import 'package:pull/models/pullmatch.dart';
import 'package:pull/providers/match_list.dart';
import 'package:pull/providers/max_concurrent_matches.dart';
import 'package:pull/ui_widgets/alert_dialogues/report_dialogue.dart';
import 'package:pull/ui_widgets/alert_dialogues/unmatch_dialogue.dart';

class MatchListPage extends ConsumerStatefulWidget {
  const MatchListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MatchListPage> createState() => _MatchListState();
}

class _MatchListState extends ConsumerState<MatchListPage> {

  @override
  Widget build(BuildContext context) {

    List<PullMatch> matchList = ref.watch(matchListProvider);
    print("length of match list: ${matchList.length}");
    List<Widget> displayList = [];
    for(int i = 0; i < matchList.length; i++){
      displayList.add(MatchListItem(
        match: matchList[i],
      ));
    }
    for(int i = matchList.length; i < ref.read(maxConcurrentMatchesProvider); i++){
      displayList.add(EmptyMatchListItem());
    }
    return Column(
      children: displayList,
    );
  }
}

class MatchListItem extends StatelessWidget {
  const MatchListItem({
    Key? key,
    required this.match,
  }) : super(key: key);

  final PullMatch match;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            print("gesture detected");
            print("uuid: ${match.person.uuid}");
            //todo figure out how to make this work properly
            context.go("/chat/${match.person.uuid}");
          },
          child: Slidable(
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              //dismissible: DismissiblePane(onDismissed: () {},),
              children: [
                SlidableAction(
                  onPressed: (context){
                    showDialog(context: context, builder: (BuildContext context) {
                      return UnmatchDialogue(

                      );
                    });
                  },
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: "Unmatch",
                ),
                SlidableAction(
                  onPressed: (context){
                    showDialog(context: context, builder: (BuildContext context) {
                      return ReportDialogue();
                    });
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.flag,
                  label: "Report",
                ),
              ],
            ),
            child: Row(
              children: [
                //display their profile picture (first one in their profile)
                CircleAvatar(
                  radius: 30,
                  backgroundImage: Image.file(match.person.images[0]!).image,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //name
                        Text(match.person.name),
                        //most recent message
                        Container(
                          child: Text(
                              (match.chat.messages.isNotEmpty)? match.chat.messages.last.message: '',
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyMatchListItem extends StatelessWidget {
  const EmptyMatchListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DottedBorder(
            strokeWidth: 2,
            dashPattern: [6, 6],
            color: Colors.lightBlueAccent,
            borderType: BorderType.RRect,
            radius: const Radius.circular(12.0),
            child: SizedBox(
              height: 60,
              width: constraints.maxWidth,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text("This is an empty slot, you can go find another match if you'd like."),
                  ),
                ),
              ),
            )
          ),
        );
      }
    );
  }
}
