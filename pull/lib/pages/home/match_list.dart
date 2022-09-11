import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchListPage extends ConsumerStatefulWidget {
  const MatchListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MatchListPage> createState() => _MatchListState();
}

class _MatchListState extends ConsumerState<MatchListPage> {
  @override
  Widget build(BuildContext context) {
    return Text("Hello there bud.");
  }
}