// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'meeting_status.g.dart';

class MeetingStatus extends EnumClass {
  static Serializer<MeetingStatus> get serializer => _$meetingStatusSerializer;

  static BuiltSet<MeetingStatus> get values => _$values;

  static MeetingStatus valueOf(String name) => _$valueOf(name);

  // positive
  static const MeetingStatus pending = _$pending;
  static const MeetingStatus rescheduled = _$rescheduled;
  static const MeetingStatus accepted = _$accepted;
  static const MeetingStatus postPending = _$postPending;
  static const MeetingStatus postRescheduled = _$postRescheduled;

  // negative
  static const MeetingStatus rejected = _$rejected;
  static const MeetingStatus cancelled = _$cancelled;
  static const MeetingStatus postRejected = _$postRejected;
  static const MeetingStatus postCancelled = _$postCancelled;

  const MeetingStatus._(String name) : super(name);
}
