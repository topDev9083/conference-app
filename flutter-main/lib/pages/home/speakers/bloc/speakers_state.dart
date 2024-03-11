import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../models/data/user_data.dart';
import '../../../../models/states/api_state.dart';

part 'speakers_state.g.dart';

abstract class SpeakersState
    implements Built<SpeakersState, SpeakersStateBuilder> {
  factory SpeakersState([final void Function(SpeakersStateBuilder) updates]) =
      _$SpeakersState;

  SpeakersState._();

  static void _initializeBuilder(final SpeakersStateBuilder b) =>
      b..speakersSearch = '';

  String get speakersSearch;

  ApiState<BuiltList<UserData>> get speakersApi;

  BuiltMap<int, ApiState<void>> get addToAgendaApi;
}
