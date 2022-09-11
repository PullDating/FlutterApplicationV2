import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileOverviewPage extends ConsumerStatefulWidget {
  const ProfileOverviewPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileOverviewPage> createState() => _ProfileOverviewPageState();
}

class _ProfileOverviewPageState extends ConsumerState<ProfileOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Text("Hello there laddie.");

  }
}