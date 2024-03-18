import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../models/data/grouped_sponsors_data.dart';
import '../../../../models/data/sponsor_data.dart';
import '../../../../models/states/api_state.dart';

part 'sponsors_state.g.dart';

abstract class SponsorsState
    implements Built<SponsorsState, SponsorsStateBuilder> {
  factory SponsorsState([final void Function(SponsorsStateBuilder) updates]) =
      _$SponsorsState;

  SponsorsState._();

  static void _initializeBuilder(final SponsorsStateBuilder b) =>
      b..moveTosponsor = '1';

  String get moveTosponsor;

  ApiState<BuiltList<SponsorData>> get getSponsorsApi;

  BuiltList<GroupedSponsorsData>? get groupedSponsors;
}
