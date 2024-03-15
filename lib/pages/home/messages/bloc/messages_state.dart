import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../models/data/user_data.dart';
import '../../../../models/states/api_state.dart';

part 'messages_state.g.dart';

abstract class MessagesState
    implements Built<MessagesState, MessagesStateBuilder> {
  factory MessagesState([final void Function(MessagesStateBuilder) updates]) =
      _$MessagesState;

  MessagesState._();

  static void _initializeBuilder(final MessagesStateBuilder b) =>
      b..usersSearch = '';

  String get usersSearch;

  ApiState<BuiltList<UserData>> get usersApi;
}
