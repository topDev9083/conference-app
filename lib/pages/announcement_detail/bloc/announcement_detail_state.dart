import 'package:built_value/built_value.dart';

import '../../../models/data/announcement_data.dart';
import '../../../models/states/api_state.dart';

part 'announcement_detail_state.g.dart';

abstract class AnnouncementDetailState
    implements Built<AnnouncementDetailState, AnnouncementDetailStateBuilder> {
  factory AnnouncementDetailState([
    final void Function(AnnouncementDetailStateBuilder) updates,
  ]) = _$AnnouncementDetailState;

  AnnouncementDetailState._();

  static void _initializeBuilder(final AnnouncementDetailStateBuilder b) => b;

  AnnouncementData get announcement;

  ApiState<void> get markAnnouncementAsReadApi;
}
