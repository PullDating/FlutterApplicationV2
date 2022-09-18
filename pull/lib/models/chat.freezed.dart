// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Chat {
//don't need to store the uuids since they are in either the person class under match,
//or in the uuid provider for the user using the app.
  ///the room id, used for database access. (constructed from the uuid pair)
  String get roomid =>
      throw _privateConstructorUsedError; //don't need to store the uuids since they are in either the person class under match,
//or in the uuid provider for the user using the app.
  ///the room id, used for database access. (constructed from the uuid pair)
  set roomid(String value) => throw _privateConstructorUsedError;

  ///the list of messages in that chat thus far.
  List<Message> get messages => throw _privateConstructorUsedError;

  ///the list of messages in that chat thus far.
  set messages(List<Message> value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res>;
  $Res call({String roomid, List<Message> messages});
}

/// @nodoc
class _$ChatCopyWithImpl<$Res> implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  final Chat _value;
  // ignore: unused_field
  final $Res Function(Chat) _then;

  @override
  $Res call({
    Object? roomid = freezed,
    Object? messages = freezed,
  }) {
    return _then(_value.copyWith(
      roomid: roomid == freezed
          ? _value.roomid
          : roomid // ignore: cast_nullable_to_non_nullable
              as String,
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc
abstract class _$$_ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$$_ChatCopyWith(_$_Chat value, $Res Function(_$_Chat) then) =
      __$$_ChatCopyWithImpl<$Res>;
  @override
  $Res call({String roomid, List<Message> messages});
}

/// @nodoc
class __$$_ChatCopyWithImpl<$Res> extends _$ChatCopyWithImpl<$Res>
    implements _$$_ChatCopyWith<$Res> {
  __$$_ChatCopyWithImpl(_$_Chat _value, $Res Function(_$_Chat) _then)
      : super(_value, (v) => _then(v as _$_Chat));

  @override
  _$_Chat get _value => super._value as _$_Chat;

  @override
  $Res call({
    Object? roomid = freezed,
    Object? messages = freezed,
  }) {
    return _then(_$_Chat(
      roomid: roomid == freezed
          ? _value.roomid
          : roomid // ignore: cast_nullable_to_non_nullable
              as String,
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc

class _$_Chat with DiagnosticableTreeMixin implements _Chat {
  _$_Chat({required this.roomid, required this.messages});

//don't need to store the uuids since they are in either the person class under match,
//or in the uuid provider for the user using the app.
  ///the room id, used for database access. (constructed from the uuid pair)
  @override
  String roomid;

  ///the list of messages in that chat thus far.
  @override
  List<Message> messages;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Chat(roomid: $roomid, messages: $messages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Chat'))
      ..add(DiagnosticsProperty('roomid', roomid))
      ..add(DiagnosticsProperty('messages', messages));
  }

  @JsonKey(ignore: true)
  @override
  _$$_ChatCopyWith<_$_Chat> get copyWith =>
      __$$_ChatCopyWithImpl<_$_Chat>(this, _$identity);
}

abstract class _Chat implements Chat {
  factory _Chat({required String roomid, required List<Message> messages}) =
      _$_Chat;

  @override //don't need to store the uuids since they are in either the person class under match,
//or in the uuid provider for the user using the app.
  ///the room id, used for database access. (constructed from the uuid pair)
  String
      get roomid; //don't need to store the uuids since they are in either the person class under match,
//or in the uuid provider for the user using the app.
  ///the room id, used for database access. (constructed from the uuid pair)
  set roomid(String value);
  @override

  ///the list of messages in that chat thus far.
  List<Message> get messages;

  ///the list of messages in that chat thus far.
  set messages(List<Message> value);
  @override
  @JsonKey(ignore: true)
  _$$_ChatCopyWith<_$_Chat> get copyWith => throw _privateConstructorUsedError;
}
