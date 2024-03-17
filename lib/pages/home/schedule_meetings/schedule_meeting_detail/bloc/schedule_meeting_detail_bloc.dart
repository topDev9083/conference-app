import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/event_bloc.dart';
import '../../../../../bloc/profile_bloc.dart';
import '../../../../../extensions/iterable.dart';
import '../../../../../flutter_i18n/translation_keys.dart';
import '../../../../../models/data/custom_field_data.dart';
import '../../../../../models/data/grouped_time_slots_data.dart';
import '../../../../../models/data/meeting_data.dart';
import '../../../../../models/data/socket_notification_data.dart';
import '../../../../../models/data/user_data.dart';
import '../../../../../models/enums/custom_field_type.dart';
import '../../../../../models/enums/meeting_status.dart';
import '../../../../../models/response/api_response.dart';
import '../../../../../services/meeting_service.dart';
import '../../../../../services/socket_service.dart';
import '../../../../../services/user_service.dart';
import '../../../../../utils/dio.dart';
import '../../../../../utils/pedantic.dart';
import '../../../../../widgets/cubit.dart';
import 'schedule_meeting_detail_state.dart';

class ScheduleMeetingDetailBloc extends WCCubit<ScheduleMeetingDetailState> {
  StreamSubscription? _onScheduleMeetingSub;
  CancelToken? _getUserCancelToken;
  CancelToken? _getColleaguesCancelToken;
  ProfileBloc profileBloc;
  EventBloc eventBloc;

  ScheduleMeetingDetailBloc({
    required final int userId,
    required this.profileBloc,
    required this.eventBloc,
  }) : super(
          ScheduleMeetingDetailState((final b) => b..userId = userId),
        ) {
    getUserDetail();
    _onScheduleMeetingSub =
        socketService.onScheduleMeeting.listen(_onScheduleMeeting);
  }

  factory ScheduleMeetingDetailBloc.of(final BuildContext context) =>
      BlocProvider.of<ScheduleMeetingDetailBloc>(context);

  @override
  Future<void> close() {
    _onScheduleMeetingSub?.cancel();
    _getColleaguesCancelToken?.cancel();
    return super.close();
  }

  void _onScheduleMeeting(
    final SocketNotificationData<MeetingData> notification,
  ) {
    final meeting = notification.body;
    if ([meeting.fromUserId, meeting.toUserId].contains(state.userId)) {
      getUserDetail();
    }
  }

  void updateUserId(final int userId) {
    emit(
      state.rebuild(
        (final b) => b
          ..userId = userId
          ..userApi.data = null
          ..colleaguesApi.data = null,
      ),
    );
    getUserDetail();
  }

  void updateUserNote(final String note) {
    emit(
      state.rebuild(
        (final b) => b.userApi.data = b.userApi.data
            ?.rebuild((final bData) => bData.note = note.isEmpty ? null : note),
      ),
    );
  }

  Future<void> getUserDetail() async {
    emit(
      state.rebuild(
        (final b) => b
          ..userApi.isApiInProgress = true
          ..userApi.error = null,
      ),
    );
    try {
      cancelDioToken(_getColleaguesCancelToken);
      cancelDioToken(_getUserCancelToken);
      _getUserCancelToken = CancelToken();
      var user = await userService.getUserById(
        state.userId,
        cancelToken: _getUserCancelToken,
      );
      if (user.meeting != null) {
        user = user.rebuild(
          (final b) => b.meeting.groupedOtherTimeSlots =
              GroupedTimeSlotsData.fromTimeSlots(
            user.meeting!.otherTimeSlots!,
            zone: eventBloc.state.getEventApi.data!.timeZone!.zone,
          ).toBuilder(),
        );
      }
      emit(state.rebuild((final b) => b.userApi.data = user));
      unAwaited(getColleagues());
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(state.rebuild((final b) => b.userApi.error = metaData.message));
      }
    }
    emit(state.rebuild((final b) => b.userApi.isApiInProgress = false));
  }

  BuiltList<CustomFieldData>? getFormattedCustomFieldValuesByTypes(
    final List<CustomFieldType> types,
  ) {
    if (state.userApi.data!.formattedCustomFieldsValues == null) {
      return null;
    }
    return BuiltList(
      state.userApi.data!.formattedCustomFieldsValues!
          .where((final cf) => types.contains(cf.type)),
    );
  }

  Future<void> getColleagues() async {
    final user = state.userApi.data;
    if (user?.organizationId == null) {
      return;
    }
    if (state.colleaguesApi.isApiInProgress) {
      return;
    }
    if (state.colleaguesApi.data != null) {
      return;
    }
    _getColleaguesCancelToken = CancelToken();
    emit(
      state.rebuild(
        (final b) => b
          ..colleaguesApi.isApiInProgress = true
          ..colleaguesApi.error = null,
      ),
    );
    try {
      final users = await userService.getUsersByOrganizationId(
        user!.organizationId!,
        cancelToken: _getColleaguesCancelToken,
      );
      final colleagues = BuiltList<UserData>(
        users.where((final user) => user.id != state.userId),
      );
      emit(state.rebuild((final b) => b.colleaguesApi.data = colleagues));
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(
          state.rebuild((final b) => b.colleaguesApi.error = metaData.message),
        );
      }
    }
    emit(state.rebuild((final b) => b.colleaguesApi.isApiInProgress = false));
  }

  void toggleSelectedTimeSlotId(
    final int id, {
    final bool isSingleSelection = false,
  }) {
    if (state.selectedTimeSlotIds.contains(id)) {
      emit(state.rebuild((final b) => b.selectedTimeSlotIds.remove(id)));
    } else {
      emit(
        state.rebuild((final b) {
          if (isSingleSelection) {
            b.selectedTimeSlotIds.clear();
          }
          b.selectedTimeSlotIds.add(id);
        }),
      );
    }
  }

  void updateMeetingRequestMessage(final String message) {
    emit(state.rebuild((final b) => b.meetingRequestMessage = message));
  }

  Future<void> getAvailableTimeSlots() async {
    if (state.timeSlotsApi.isApiInProgress) {
      return;
    }
    emit(
      state.rebuild(
        (final b) => b
          ..timeSlotsApi.isApiInProgress = true
          ..timeSlotsApi.error = null,
      ),
    );

    try {
      final timeSlots =
          await userService.getAvailableTimeSlotsByUserId(state.userId);
      final selectedTimeSlotIds = SetBuilder<int>();
      if (state.userApi.data!.meeting != null &&
          ![
            MeetingStatus.cancelled,
            MeetingStatus.postCancelled,
            MeetingStatus.rejected,
            MeetingStatus.postRejected,
          ].contains(state.userApi.data!.meeting!.status)) {
        for (final ots in state.userApi.data!.meeting!.otherTimeSlots!) {
          final ts = timeSlots.firstWhereOrNull(
            (final ts) =>
                ts.startDate.toIso8601String() + ts.endDate.toIso8601String() ==
                ots.startDate.toIso8601String() + ots.endDate.toIso8601String(),
          );
          if (ts != null) {
            selectedTimeSlotIds.add(ts.id);
          }
        }
      }
      emit(
        state.rebuild(
          (final b) => b
            ..timeSlotsApi.data = timeSlots
            ..groupedTimeSlots = GroupedTimeSlotsData.fromTimeSlots(
              timeSlots,
              zone: eventBloc.state.getEventApi.data!.timeZone!.zone,
            ).toBuilder()
            ..selectedTimeSlotIds = selectedTimeSlotIds,
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(state.rebuild((final b) => b.timeSlotsApi.error = metaData.message));
    }
    emit(state.rebuild((final b) => b.timeSlotsApi.isApiInProgress = false));
  }

  Future<void> sendMeetingRequest() async {
    emit(
      state.rebuild(
        (final b) => b
          ..meetingRequestApi.isApiInProgress = true
          ..meetingRequestApi.error = null
          ..meetingRequestApi.message = null,
      ),
    );

    try {
      final profileId = profileBloc.state!.id;
      final currentMeeting = state.userApi.data!.meeting;
      MeetingStatus? newMeetingStatus;
      String? successMessage;
      if (currentMeeting != null) {
        if ([MeetingStatus.pending].contains(currentMeeting.status) &&
            currentMeeting.fromUserId == profileId) {
          newMeetingStatus = MeetingStatus.pending;
          successMessage = 'Meeting request updated successfully';
        } else if ([MeetingStatus.pending].contains(currentMeeting.status) &&
            currentMeeting.toUserId == profileId) {
          newMeetingStatus = MeetingStatus.rescheduled;
          successMessage = 'Meeting reschedule request sent successfully';
        } else if ([MeetingStatus.accepted].contains(currentMeeting.status) &&
            currentMeeting.fromUserId == profileId) {
          newMeetingStatus = MeetingStatus.postPending;
          successMessage = 'Meeting reschedule request sent successfully';
        } else if ([MeetingStatus.accepted].contains(currentMeeting.status) &&
            currentMeeting.toUserId == profileId) {
          newMeetingStatus = MeetingStatus.postRescheduled;
          successMessage = 'Meeting reschedule request sent successfully';
        } else if ([MeetingStatus.postPending]
                .contains(currentMeeting.status) &&
            currentMeeting.fromUserId == profileId) {
          newMeetingStatus = MeetingStatus.postPending;
          successMessage = 'Meeting reschedule request updated successfully';
        } else if ([MeetingStatus.postPending]
                .contains(currentMeeting.status) &&
            currentMeeting.toUserId == profileId) {
          newMeetingStatus = MeetingStatus.postRescheduled;
          successMessage = 'Meeting reschedule request sent successfully';
        }
      }

      MeetingData meeting;
      if (newMeetingStatus != null) {
        meeting = await meetingService.updateMeetingById(
          meetingId: currentMeeting!.id,
          status: newMeetingStatus,
          timeSlotIds: state.selectedTimeSlotIds,
          message: state.meetingRequestMessage,
        );
      } else {
        meeting = await meetingService.createMeeting(
          toUserId: state.userId,
          timeSlotIds: state.selectedTimeSlotIds,
          message: state.meetingRequestMessage,
        );
      }
      emit(
        state.rebuild(
          (final b) => b
            ..userApi.data = state.userApi.data!
                .rebuild((final bData) => bData.meeting.replace(meeting))
            ..meetingRequestApi.message =
                successMessage ?? 'Meeting request sent successfully',
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state
            .rebuild((final b) => b.meetingRequestApi.error = metaData.message),
      );
    }
    emit(
      state.rebuild((final b) => b.meetingRequestApi.isApiInProgress = false),
    );
  }

  Future<void> updateMeetingStatus(final MeetingStatus status) async {
    emit(
      state.rebuild(
        (final b) => b
          ..meetingRequestApi.isApiInProgress = true
          ..meetingRequestApi.error = null
          ..meetingRequestApi.message = null,
      ),
    );
    try {
      final meeting = await meetingService.updateMeetingById(
        meetingId: state.userApi.data!.meeting!.id,
        status: status,
        timeSlotIds: state.selectedTimeSlotIds,
        message: state.meetingRequestMessage,
      );
      String? message;
      switch (status) {
        case MeetingStatus.pending:
          message = TranslationKeys
              .Schedule_Meetings_User_Detail_Meeting_Request_Updated_Done;
          break;
        case MeetingStatus.rescheduled:
          message = TranslationKeys
              .Schedule_Meetings_User_Detail_Meeting_Request_Rescheduled_Done;
          break;
        case MeetingStatus.postPending:
          message =
              TranslationKeys.Schedule_Meetings_User_Detail_Meeting_Update_Done;
          break;
        case MeetingStatus.postRescheduled:
          message =
              TranslationKeys.Schedule_Meetings_User_Detail_Meeting_Update_Done;
          break;
        case MeetingStatus.cancelled:
          message =
              TranslationKeys.Schedule_Meetings_User_Detail_Meeting_Cancel_Done;
          break;
        case MeetingStatus.rejected:
          message =
              TranslationKeys.Schedule_Meetings_User_Detail_Meeting_Reject_Done;
          break;
        case MeetingStatus.postCancelled:
          message =
              TranslationKeys.Schedule_Meetings_User_Detail_Meeting_Cancel_Done;
          break;
        case MeetingStatus.postRejected:
          message =
              TranslationKeys.Schedule_Meetings_User_Detail_Meeting_Reject_Done;
          break;
        default:
          message = null;
          break;
      }
      emit(
        state.rebuild(
          (final b) => b
            ..userApi.data = state.userApi.data!
                .rebuild((final bData) => bData.meeting.replace(meeting))
            ..meetingRequestApi.message = message,
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state
            .rebuild((final b) => b.meetingRequestApi.error = metaData.message),
      );
    }
    emit(
      state.rebuild((final b) => b.meetingRequestApi.isApiInProgress = false),
    );
  }

  Future<void> acceptMeeting() async {
    emit(
      state.rebuild(
        (final b) => b
          ..meetingRequestApi.isApiInProgress = true
          ..meetingRequestApi.error = null
          ..meetingRequestApi.message = null,
      ),
    );
    try {
      final meeting = await meetingService.updateMeetingById(
        meetingId: state.userApi.data!.meeting!.id,
        status: MeetingStatus.accepted,
        timeSlotIds: BuiltSet(state.selectedTimeSlotIds),
      );
      emit(
        state.rebuild(
          (final b) => b
            ..userApi.data = state.userApi.data!
                .rebuild((final bData) => bData.meeting.replace(meeting))
            ..meetingRequestApi.message = 'Meeting request accepted',
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state
            .rebuild((final b) => b.meetingRequestApi.error = metaData.message),
      );
    }
    emit(
      state.rebuild((final b) => b.meetingRequestApi.isApiInProgress = false),
    );
  }

  void resetTimeSlotFields() {
    emit(
      state.rebuild(
        (final b) => b
          ..selectedTimeSlotIds.clear()
          ..timeSlotsApi.data = null
          ..meetingRequestMessage = ''
          ..groupedTimeSlots = null,
      ),
    );
  }
}
