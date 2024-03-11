import 'package:built_value/built_value.dart';

import '../../../models/data/map_location_data.dart';
import '../../../models/states/api_state.dart';

part 'map_location_detail_state.g.dart';

abstract class MapLocationDetailState
    implements Built<MapLocationDetailState, MapLocationDetailStateBuilder> {
  factory MapLocationDetailState([
    final void Function(MapLocationDetailStateBuilder) updates,
  ]) = _$MapLocationDetailState;

  MapLocationDetailState._();

  static void _initializeBuilder(final MapLocationDetailStateBuilder b) => b;

  int get mapLocationId;

  ApiState<MapLocationData> get mapLocationApi;
}
