import 'package:built_value/built_value.dart';

import '../../../models/states/api_state.dart';

part 'update_user_note_state.g.dart';

abstract class UpdateUserNoteState
    implements Built<UpdateUserNoteState, UpdateUserNoteStateBuilder> {
  factory UpdateUserNoteState([
    final void Function(UpdateUserNoteStateBuilder) updates,
  ]) = _$UpdateUserNoteState;

  UpdateUserNoteState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final UpdateUserNoteStateBuilder b) => b..note = '';

  int get userId;

  String get note;

  ApiState<void> get updateNoteApi;
}
