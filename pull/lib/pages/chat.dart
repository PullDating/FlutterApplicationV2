import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/message.dart';
import 'package:pull/models/pullmatch.dart';
import 'package:pull/providers/match_list.dart';
import 'package:pull/providers/network/uuid.dart';

//todo move this from here to some shared location, if it's even needed.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({Key? key, required this.uuid}) : super(key: key);

  final String uuid;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final List<types.Message> _messages = []; //list of messages
  late PullMatch _match;
  var _user;
  var _otheruser;

  void _addMessages(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  void initState() {
    super.initState();
    _user = types.User(id: ref.read(uuidProvider)!); //the use of the application
    _otheruser = types.User(id: widget.uuid); //their match.

    //get the correct match from the provider.
    PullMatch? match;
    for(int i = 0 ; i < ref.read(matchListProvider).length; i++){
      if(ref.read(matchListProvider)[i].person.uuid == widget.uuid){
        match = ref.read(matchListProvider)[i];
        break;
      }
    }
    if(match == null){
      throw Exception("The match was null when that shouldn't be possible");
    }
    _match = match!;

    _populateMessages();

    // //some debug / test print stuff.
    // final _message = types.PartialText(
    //   text: "hello there, general kenobi",
    // );
    // final textMessage = types.TextMessage(
    //   author: _otheruser,
    //   createdAt: DateTime.now().millisecondsSinceEpoch,
    //   id: randomString(),
    //   text: _message.text,
    // );
    // _addMessages(textMessage);
  }

  void _populateMessages(){
    //loop through the messages of that match in the matchlist provider, and add them to the list of matches for the chat page ui
    for(int i = 0; i < _match.chat.messages.length; i++){
      _messages.add(getTextMessageFromPullMessage(_match.chat.messages[i]));
    }

  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessages(textMessage);
  }

  types.TextMessage getTextMessageFromPullMessage(PullMessage message){
    types.User otheruser = types.User(id: message.sender); //their match.
    final textMessage = types.TextMessage(
      author: otheruser,
      createdAt: message.datetime.millisecondsSinceEpoch,
      text: message.message,
      id: randomString(),
    );
    return textMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Chat(
            theme: const DefaultChatTheme(
              inputBackgroundColor: Colors.black,
              primaryColor: Colors.lightBlueAccent,
              secondaryColor: Colors.pinkAccent,
            ),
            messages: _messages,
            onSendPressed: _handleSendPressed,
            user: _user,
          ),
        ),
      ),
    );
  }
}
