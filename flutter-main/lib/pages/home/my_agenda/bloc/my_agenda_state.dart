import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../models/data/agenda_combined_data.dart';
import '../../../../models/data/agenda_data.dart';
import '../../../../models/states/api_state.dart';

part 'my_agenda_state.g.dart';

abstract class MyAgendaState
    implements Built<MyAgendaState, MyAgendaStateBuilder> {
  factory MyAgendaState([final void Function(MyAgendaStateBuilder) updates]) =
      _$MyAgendaState;

  MyAgendaState._();

  static void _initializeBuilder(final MyAgendaStateBuilder b) => b;

  ApiState<AgendaData> get getAgendaApi;

  BuiltList<AgendaCombinedData>? get combinedAgendas;

  DateTime? get startDateTimeOfStartDate;

  DateTime? get endDateTimeOfStartDate;

  BuiltMap<int, ApiState<void>> get deleteUserOccupancies;

  BuiltMap<int, ApiState<void>> get removeFromAgendaApi;
}
