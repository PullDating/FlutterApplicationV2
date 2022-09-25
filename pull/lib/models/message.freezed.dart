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
mixin _$PullMessage {
  ///indicates if the message has been read by the other party or not.
  bool get read => throw _privateConstructorUsedError;

  ///the payload of the message
  String get message => throw _privateConstructorUsedError;

  ///when the message was sent.
  DateTime get datetime => throw _privateConstructorUsedError;

  ///the uuid of the user that sent the message. It can be the person using the app
  ///or the person they have matched with.
  String get sender => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PullMessageCopyWith<PullMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PullMessageCopyWith<$Res> {
  factory $PullMessageCopyWith(
          PullMessage value, $Res Function(PullMessage) then) =
      _$PullMessageCopyWithImpl<$Res>;
  $Res call({bool read, String message, DateTime datetime, String sender});
}

/// @nodoc
class _$PullMessageCopyWithImpl<$Res> implements $PullMessageCopyWith<$Res> {
  _$PullMessageCopyWithImpl(this._value, this._then);

  final PullMessage _value;
  // ignore: unused_field
  final $Res Function(PullMessage) _then;

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
abstract class _$$_PullMessageCopyWith<$Res>
    implements $PullMessageCopyWith<$Res> {
  factory _$$_PullMessageCopyWith(
          _$_PullMessage value, $Res Function(_$_PullMessage) then) =
      __$$_PullMessageCopyWithImpl<$Res>;
  @override
  $Res call({bool read, String message, DateTime datetime, String sender});
}

/// @nodoc
class __$$_PullMessageCopyWithImpl<$Res> extends _$PullMessageCopyWithImpl<$Res>
    implements _$$_PullMessageCopyWith<$Res> {
  __$$_PullMessageCopyWithImpl(
      _$_PullMessage _value, $Res Function(_$_PullMessage) _then)
      : super(_value, (v) => _then(v as _$_PullMessage));

  @override
  _$_PullMessage get _value => super._value as _$_PullMessage;

  @override
  $Res call({
    Object? read = freezed,
    Object? message = freezed,
    Object? datetime = freezed,
    Object? sender = freezed,
  }) {
    return _then(_$_PullMessage(
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

class _$_PullMessage with DiagnosticableTreeMixin implements _PullMessage {
  _$_PullMessage(
      {required this.read,
      required this.message,
      required this.datetime,
      required this.sender});

  ///indicates if the message has been read by the other party or not.
  @override
  final bool read;

  ///the payload of the message
  @override
  final String message;

  ///when the message was sent.
  @override
  final DateTime datetime;

  ///the uuid of the user that sent the message. It can be the person using the app
  ///or the person they have matched with.
  @override
  final String sender;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PullMessage(read: $read, message: $message, datetime: $datetime, sender: $sender)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PullMessage'))
      ..add(DiagnosticsProperty('read', read))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('datetime', datetime))
      ..add(DiagnosticsProperty('sender', sender));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PullMessage &&
            const DeepCollectionEquality().equals(other.read, read) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.datetime, datetime) &&
            const DeepCollectionEquality().equals(other.sender, sender));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(read),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(datetime),
      const DeepCollectionEquality().hash(sender));

  @JsonKey(ignore: true)
  @override
  _$$_PullMessageCopyWith<_$_PullMessage> get copyWith =>
      __$$_PullMessageCopyWithImpl<_$_PullMessage>(this, _$identity);
}

abstract class _PullMessage implements PullMessage {
  factory _PullMessage(
      {required final bool read,
      required final String message,
      required final DateTime datetime,
      required final String sender}) = _$_PullMessage;

  @override

  ///indicates if the message has been read by the other party or not.
  bool get read;
  @override

  ///the payload of the message
  String get message;
  @override

  ///when the message was sent.
  DateTime get datetime;
  @override

  ///the uuid of the user that sent the message. It can be the person using the app
  ///or the person they have matched with.
  String get sender;
  @override
  @JsonKey(ignore: true)
  _$$_PullMessageCopyWith<_$_PullMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
