// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pullmatch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PullMatch {
//the unique identifier of the user, used for backend api calls
  Person get person =>
      throw _privateConstructorUsedError; //the unique identifier of the user, used for backend api calls
  set person(Person value) => throw _privateConstructorUsedError;
  Chat get chat => throw _privateConstructorUsedError;
  set chat(Chat value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PullMatchCopyWith<PullMatch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PullMatchCopyWith<$Res> {
  factory $PullMatchCopyWith(PullMatch value, $Res Function(PullMatch) then) =
      _$PullMatchCopyWithImpl<$Res>;
  $Res call({Person person, Chat chat});

  $ChatCopyWith<$Res> get chat;
}

/// @nodoc
class _$PullMatchCopyWithImpl<$Res> implements $PullMatchCopyWith<$Res> {
  _$PullMatchCopyWithImpl(this._value, this._then);

  final PullMatch _value;
  // ignore: unused_field
  final $Res Function(PullMatch) _then;

  @override
  $Res call({
    Object? person = freezed,
    Object? chat = freezed,
  }) {
    return _then(_value.copyWith(
      person: person == freezed
          ? _value.person
          : person // ignore: cast_nullable_to_non_nullable
              as Person,
      chat: chat == freezed
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as Chat,
    ));
  }

  @override
  $ChatCopyWith<$Res> get chat {
    return $ChatCopyWith<$Res>(_value.chat, (value) {
      return _then(_value.copyWith(chat: value));
    });
  }
}

/// @nodoc
abstract class _$$_PullMatchCopyWith<$Res> implements $PullMatchCopyWith<$Res> {
  factory _$$_PullMatchCopyWith(
          _$_PullMatch value, $Res Function(_$_PullMatch) then) =
      __$$_PullMatchCopyWithImpl<$Res>;
  @override
  $Res call({Person person, Chat chat});

  @override
  $ChatCopyWith<$Res> get chat;
}

/// @nodoc
class __$$_PullMatchCopyWithImpl<$Res> extends _$PullMatchCopyWithImpl<$Res>
    implements _$$_PullMatchCopyWith<$Res> {
  __$$_PullMatchCopyWithImpl(
      _$_PullMatch _value, $Res Function(_$_PullMatch) _then)
      : super(_value, (v) => _then(v as _$_PullMatch));

  @override
  _$_PullMatch get _value => super._value as _$_PullMatch;

  @override
  $Res call({
    Object? person = freezed,
    Object? chat = freezed,
  }) {
    return _then(_$_PullMatch(
      person: person == freezed
          ? _value.person
          : person // ignore: cast_nullable_to_non_nullable
              as Person,
      chat: chat == freezed
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as Chat,
    ));
  }
}

/// @nodoc

class _$_PullMatch with DiagnosticableTreeMixin implements _PullMatch {
  _$_PullMatch({required this.person, required this.chat});

//the unique identifier of the user, used for backend api calls
  @override
  Person person;
  @override
  Chat chat;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PullMatch(person: $person, chat: $chat)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PullMatch'))
      ..add(DiagnosticsProperty('person', person))
      ..add(DiagnosticsProperty('chat', chat));
  }

  @JsonKey(ignore: true)
  @override
  _$$_PullMatchCopyWith<_$_PullMatch> get copyWith =>
      __$$_PullMatchCopyWithImpl<_$_PullMatch>(this, _$identity);
}

abstract class _PullMatch implements PullMatch {
  factory _PullMatch({required Person person, required Chat chat}) =
      _$_PullMatch;

  @override //the unique identifier of the user, used for backend api calls
  Person
      get person; //the unique identifier of the user, used for backend api calls
  set person(Person value);
  @override
  Chat get chat;
  set chat(Chat value);
  @override
  @JsonKey(ignore: true)
  _$$_PullMatchCopyWith<_$_PullMatch> get copyWith =>
      throw _privateConstructorUsedError;
}
