// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Message {
  ///indicates if the message has been read by the other party or not.
  bool get read => throw _privateConstructorUsedError;

  ///indicates if the message has been read by the other party or not.
  set read(bool value) => throw _privateConstructorUsedError;

  ///the payload of the message
  String get message => throw _privateConstructorUsedError;

  ///the payload of the message
  set message(String value) => throw _privateConstructorUsedError;

  ///when the message was sent.
  DateTime get datetime => throw _privateConstructorUsedError;

  ///when the message was sent.
  set datetime(DateTime value) => throw _privateConstructorUsedError;

  ///the uuid of the user that sent the message. It can be the person using the app
  ///or the person they have matched with.
  String get sender => throw _privateConstructorUsedError;

  ///the uuid of the user that sent the message. It can be the person using the app
  ///or the person they have matched with.
  set sender(String value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res>;
  $Res call({bool read, String message, DateTime datetime, String sender});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  final Message _value;
  // ignore: unused_field
  final $Res Function(Message) _then;

  @override
  $Res call({
    Object? read = freezed,
    Object? message = freezed,
    Object? datetime = freezed,
    Object? sender = freezed,
  }) {
    return _then(_value.copyWith(
      read: read == freezed
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      datetime: datetime == freezed
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$_MessageCopyWith(
          _$_Message value, $Res Function(_$_Message) then) =
      __$$_MessageCopyWithImpl<$Res>;
  @override
  $Res call({bool read, String message, DateTime datetime, String sender});
}

/// @nodoc
class __$$_MessageCopyWithImpl<$Res> extends _$MessageCopyWithImpl<$Res>
    implements _$$_MessageCopyWith<$Res> {
  __$$_MessageCopyWithImpl(_$_Message _value, $Res Function(_$_Message) _then)
      : super(_value, (v) => _then(v as _$_Message));

  @override
  _$_Message get _value => super._value as _$_Message;

  @override
  $Res call({
    Object? read = freezed,
    Object? message = freezed,
    Object? datetime = freezed,
    Object? sender = freezed,
  }) {
    return _then(_$_Message(
      read: read == freezed
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      datetime: datetime == freezed
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Message with DiagnosticableTreeMixin implements _Message {
  _$_Message(
      {required this.read,
      required this.message,
      required this.datetime,
      required this.sender});

  ///indicates if the message has been read by the other party or not.
  @override
  bool read;

  ///the payload of the message
  @override
  String message;

  ///when the message was sent.
  @override
  DateTime datetime;

  ///the uuid of the user that sent the message. It can be the person using the app
  ///or the person they have matched with.
  @override
  String sender;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Message(read: $read, message: $message, datetime: $datetime, sender: $sender)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Message'))
      ..add(DiagnosticsProperty('read', read))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('datetime', datetime))
      ..add(DiagnosticsProperty('sender', sender));
  }

  @JsonKey(ignore: true)
  @override
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      __$$_MessageCopyWithImpl<_$_Message>(this, _$identity);
}

abstract class _Message implements Message {
  factory _Message(
      {required bool read,
      required String message,
      required DateTime datetime,
      required String sender}) = _$_Message;

  @override

  ///indicates if the message has been read by the other party or not.
  bool get read;

  ///indicates if the message has been read by the other party or not.
  set read(bool value);
  @override

  ///the payload of the message
  String get message;

  ///the payload of the message
  set message(String value);
  @override

  ///when the message was sent.
  DateTime get datetime;

  ///when the message was sent.
  set datetime(DateTime value);
  @override

  ///the uuid of the user that sent the message. It can be the person using the app
  ///or the person they have matched with.
  String get sender;

  ///the uuid of the user that sent the message. It can be the person using the app
  ///or the person they have matched with.
  set sender(String value);
  @override
  @JsonKey(ignore: true)
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      throw _privateConstructorUsedError;
}
