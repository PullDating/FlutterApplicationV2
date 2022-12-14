import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'message.freezed.dart';
// optional: Since our message class is serializable, we must add this line.
// But if Message was not serializable, we could skip it.
//part 'message.g.dart';

@freezed
class PullMessage with _$PullMessage {
  factory PullMessage({
    ///indicates if the message has been read by the other party or not.
    required bool read,
    ///the payload of the message
    required String message,
    ///when the message was sent.
    required DateTime datetime,
    ///the uuid of the user that sent the message. It can be the person using the app
    ///or the person they have matched with.
    required String sender,
  }) = _PullMessage;

//factory Message.fromJson(Map<String, Object?> json)
//=> _$MessageFromJson(json);
}