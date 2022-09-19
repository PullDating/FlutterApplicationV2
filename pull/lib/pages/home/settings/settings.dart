import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull/providers/paused.dart';
import 'package:pull/ui_widgets/alert_dialogues/delete_account_dialogue.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              context.go('/home?index=2');
            },
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Github',
              style: Theme.of(context).textTheme.headline5,
            ),

            onTap: () {
              launchUrl(
                Uri.parse('https://github.com/PullDating/FlutterApplicationV2'),
                mode: LaunchMode.inAppWebView,
              );
            },
          ),
          ListTile(
            title: Text(
              'Website',
              style: Theme.of(context).textTheme.headline5,
            ),
            onTap: () {
              launchUrl(Uri.parse('https://pulldating.tips'));
            },
          ),
          ListTile(
            title: Text(
              'Licence',
              style: Theme.of(context).textTheme.headline5,
            ),
            onTap: () {
              //todo add logic to show licence here
            },
          ),
          ListTile(
            title: Text(
              'Pause',
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: (ref.read(accountPausedProvider)) ? Text("Account currently paused.") : Text("Account currently unpaused."),
            onTap: () async {
              //todo add the logic to call backend request here.
            },
          ),
          ListTile(
            title: Text(
              'Sign Out',
              style: Theme.of(context).textTheme.headline5,
            ),
            onTap: () async {
              //todo add the logic to call backend request here.
            },
          ),
          ListTile(
            title: Text(
              'Delete Account',
              style: Theme.of(context).textTheme.headline5,
            ),
            onTap: () async {
              //todo add the logic to call backend request here.
              showDialog(context: context, builder: (context){
                return DeleteAccountDialogue();
              });
            },
          )
        ],
      ),
    );
  }
}
