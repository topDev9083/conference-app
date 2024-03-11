import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/data/meeting_data.dart';
import '../../../../models/data/socket_notification_data.dart';
import '../../../../models/enums/meeting_status.dart';
import '../../../../models/response/api_response.dart';
import '../../../../services/meeting_service.dart';
import '../../../../services/socket_service.dart';
import '../../../../widgets/cubit.dart';
import 'meeting_management_state.dart';

class MeetingManagementBloc extends WCCubit<MeetingManagementState> {
  StreamSubscription? _onScheduleMeetingSub;

  MeetingManagementBloc()
      : super(
          MeetingManagementState(
            (final b) => b.selectedMeetingStatus = MeetingStatus.pending,
          ),
        ) {
    getMyMeetings();
    _onScheduleMeetingSub =
        socketService.onScheduleMeeting.listen(_onScheduleMeeting);
  }

  factory MeetingManagementBloc.of(final BuildContext context) =>
      BlocProvider.of<MeetingManagementBloc>(context);

  void _onScheduleMeeting(final SocketNotificationData<MeetingData> notification) {
    getMyMeetings();
  }

  @override
  Future<void> close() {
    _onScheduleMeetingSub?.cancel();
    return super.close();
  }

  void updateSelectedMeetingStatus(final MeetingStatus? meetingStatus) {
    emit(
      state.rebuild(
        (final b) => b
          ..selectedMeetingStatus = meetingStatus
          ..filteredMeetings = null
          ..getMeetingsApi.data = null,
      ),
    );
    getMyMeetings();
  }

  Future<void> getMyMeetings() async {
    emit(
      state.rebuild(
        (final b) => b.getMeetingsApi
          ..isApiInProgress = true
          ..error = null
          ..data = null,
      ),
    );
    try {
      final meetings = await meetingService.getMyMeetings();
      final Iterable<MeetingData> filteredMeetings;
      if (state.selectedMeetingStatus == MeetingStatus.pending) {
        filteredMeetings = meetings.where(
          (final meeting) => [
            MeetingStatus.pending,
            MeetingStatus.postPending,
            MeetingStatus.rescheduled,
            MeetingStatus.postRescheduled,
          ].contains(meeting.status),
        );
      } else if (state.selectedMeetingStatus == MeetingStatus.accepted) {
        filteredMeetings = meetings.where(
          (final meeting) => [
            MeetingStatus.accepted,
            MeetingStatus.postPending,
            MeetingStatus.postRescheduled,
          ].contains(meeting.status),
        );
      } else if (state.selectedMeetingStatus == MeetingStatus.cancelled) {
        filteredMeetings = meetings.where(
          (final meeting) => [
            MeetingStatus.rejected,
            MeetingStatus.cancelled,
            MeetingStatus.postRejected,
            MeetingStatus.postCancelled,
          ].contains(meeting.status),
        );
      } else {
        filteredMeetings = meetings.toList();
      }

      emit(
        state.rebuild(
          (final b) => b
            ..getMeetingsApi.data = meetings
            ..filteredMeetings.replace(filteredMeetings),
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.getMeetingsApi.error = metaData.message),
      );
    }
    emit(state.rebuild((final b) => b.getMeetingsApi.isApiInProgress = false));
  }
}
