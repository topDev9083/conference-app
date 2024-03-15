import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../../models/data/message_data.dart';
import '../../../../../models/data/user_data.dart';
import '../../../../../models/states/api_state.dart';

part 'thread_detail_state.g.dart';

abstract class ThreadDetailState
    implements Built<ThreadDetailState, ThreadDetailStateBuilder> {
  factory ThreadDetailState([
    final void Function(ThreadDetailStateBuilder) updates,
  ]) = _$ThreadDetailState;

  ThreadDetailState._();

  static void _initializeBuilder(final ThreadDetailStateBuilder b) =>
      b..message = '';

  int get userId;

  ApiState<UserData> get userApi;

  ApiState<BuiltList<MessageData>> get messagesApi;

  ApiState<void> get attachmentApi;

  String get message;
}
