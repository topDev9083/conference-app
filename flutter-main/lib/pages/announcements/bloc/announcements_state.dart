import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../models/data/announcement_data.dart';
import '../../../models/states/api_state.dart';

part 'announcements_state.g.dart';

abstract class AnnouncementsState
    implements Built<AnnouncementsState, AnnouncementsStateBuilder> {
  factory AnnouncementsState([
    final void Function(AnnouncementsStateBuilder) updates,
  ]) = _$AnnouncementsState;

  AnnouncementsState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final AnnouncementsStateBuilder b) => b;

  @BuiltValueHook(finalizeBuilder: true)
  static void _finalize(final AnnouncementsStateBuilder b) {
    if (b.getAnnouncementsApi.data == null) {
      b.unreadCount = 0;
    } else {
      b.unreadCount =
          b.getAnnouncementsApi.data!.where((final an) => !an.isRead!).length;
    }
  }

  ApiState<BuiltList<AnnouncementData>> get getAnnouncementsApi;

  int get unreadCount;
}
