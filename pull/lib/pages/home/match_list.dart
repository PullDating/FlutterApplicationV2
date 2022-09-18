import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull/models/person.dart';
import 'package:pull/models/pullmatch.dart';
import 'package:pull/providers/match_list.dart';

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
    List<MatchListItem> displayList = [];
    for(int i = 0; i < matchList.length; i++){
      displayList.add(MatchListItem(
        match: matchList[i],
      ));
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
          },
          child: Slidable(
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              //dismissible: DismissiblePane(onDismissed: () {},),
              children: [
                SlidableAction(
                  onPressed: (context) => (){},
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: "Unmatch",
                ),
                SlidableAction(
                  onPressed: (context) => (){},
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
