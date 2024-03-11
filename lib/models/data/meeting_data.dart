import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../others/meeting_status_events.dart';
import '../enums/meeting_status.dart';
import '../serializers.dart';
import 'grouped_time_slots_data.dart';
import 'table_data.dart';
import 'time_slot_data.dart';
import 'user_data.dart';

part 'meeting_data.g.dart';

abstract class MeetingData implements Built<MeetingData, MeetingDataBuilder> {
  factory MeetingData([final void Function(MeetingDataBuilder) updates]) =
      _$MeetingData;

  MeetingData._();

  static Serializer<MeetingData> get serializer => _$meetingDataSerializer;

  static void _initializeBuilder(final MeetingDataBuilder b) => b;

  int get id;

  DateTime get updatedOn;

  DateTime get createdOn;

  int get fromUserId;

  int get toUserId;

  int? get tableId;

  int? get acceptedTimeSlotId;

  MeetingStatus get status;

  String? get fromMessage;

  String? get toMessage;

  // custom fields
  TimeSlotData? get acceptedTimeSlot;

  BuiltList<TimeSlotData>? get otherTimeSlots;

  BuiltList<GroupedTimeSlotsData>? get groupedOtherTimeSlots;

  UserData? get fromUser;

  UserData? get toUser;

  TableData? get table;

  // from joining
  DateTime? get timeSlotStartDate;

  DateTime? get timeSlotEndDate;

  bool isAccepted() {
    return [
      MeetingStatus.accepted,
      MeetingStatus.postRescheduled,
      MeetingStatus.postPending,
    ].contains(status);
  }

  bool isEnded() {
    return [
      MeetingStatus.cancelled,
      MeetingStatus.rejected,
      MeetingStatus.postCancelled,
      MeetingStatus.postRejected,
    ].contains(status);
  }

  int getUserId(final int profileId) {
    return profileId == fromUserId ? toUserId : fromUserId;
  }

  void callMeetingStatusEvent(
    final int profileId,
    final MeetingStatusEvents event,
  ) {
    // pending
    if (status == MeetingStatus.pending && fromUserId == profileId) {
      event.pendingMe?.call();
    } else if (status == MeetingStatus.pending && toUserId == profileId) {
      event.pendingHim?.call();
    } // rescheduled
    else if (status == MeetingStatus.rescheduled && fromUserId == profileId) {
      event.rescheduledMe?.call();
    } else if (status == MeetingStatus.rescheduled && toUserId == profileId) {
      event.rescheduledHim?.call();
    } // accepted
    else if (status == MeetingStatus.accepted && fromUserId == profileId) {
      event.acceptedMe?.call();
    } else if (status == MeetingStatus.accepted && toUserId == profileId) {
      event.acceptedHim?.call();
    } // postPending
    else if (status == MeetingStatus.postPending && fromUserId == profileId) {
      event.postPendingMe?.call();
    } else if (status == MeetingStatus.postPending && toUserId == profileId) {
      event.postPendingHim?.call();
    } // postRescheduled
    else if (status == MeetingStatus.postRescheduled &&
        fromUserId == profileId) {
      event.postRescheduledMe?.call();
    } else if (status == MeetingStatus.postRescheduled &&
        toUserId == profileId) {
      event.postRescheduledHim?.call();
    } // rejected
    else if (status == MeetingStatus.rejected && fromUserId == profileId) {
      event.rejectedMe?.call();
    } else if (status == MeetingStatus.rejected && toUserId == profileId) {
      event.rejectedHim?.call();
    } // cancelled
    else if (status == MeetingStatus.cancelled && fromUserId == profileId) {
      event.cancelledMe?.call();
    } else if (status == MeetingStatus.cancelled && toUserId == profileId) {
      event.cancelledHim?.call();
    } // postRejected
    else if (status == MeetingStatus.postRejected && fromUserId == profileId) {
      event.postRejectedMe?.call();
    } else if (status == MeetingStatus.postRejected && toUserId == profileId) {
      event.postRejectedHim?.call();
    } // postCancelled
    else if (status == MeetingStatus.postCancelled && fromUserId == profileId) {
      event.postCancelledMe?.call();
    } else if (status == MeetingStatus.postCancelled && toUserId == profileId) {
      event.postCancelledHim?.call();
    }
  }

  static MeetingData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(MeetingData.serializer, json)!;
  }

  static BuiltList<MeetingData> fromDynamics(final List<dynamic> list) {
    return BuiltList<MeetingData>(list.map((final json) => fromDynamic(json)));
  }
}
