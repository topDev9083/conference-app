import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../models/data/exhibitor_data.dart';
import '../../../../models/states/api_state.dart';

part 'exhibitors_state.g.dart';

abstract class ExhibitorsState
    implements Built<ExhibitorsState, ExhibitorsStateBuilder> {
  factory ExhibitorsState([
    final void Function(ExhibitorsStateBuilder) updates,
  ]) = _$ExhibitorsState;

  ExhibitorsState._();

  static void _initializeBuilder(final ExhibitorsStateBuilder b) =>
      b..exhibitorsSearch = '';

  String get exhibitorsSearch;

  ApiState<BuiltList<ExhibitorData>> get exhibitorsApi;
}
