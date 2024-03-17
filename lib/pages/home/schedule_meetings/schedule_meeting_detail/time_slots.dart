import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../bloc/profile_bloc.dart';
import '../../../../core/colors.dart';
import '../../../../extensions/date_time.dart';
import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../models/data/time_slot_data.dart';
import '../../../../models/enums/meeting_status.dart';
import '../../../../others/meeting_status_events.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/connection_information.dart';
import '../../../../widgets/full_screen_drawer.dart';
import '../../../../widgets/ink_well.dart';
import '../../../../widgets/outlined_button.dart';
import '../../../../widgets/static_grid.dart';
import '../../../../widgets/time_zone_bloc_builder.dart';
import 'bloc/schedule_meeting_detail_bloc.dart';
import 'bloc/schedule_meeting_detail_state.dart';

class TimeSlots extends StatefulWidget {
  final ScheduleMeetingDetailBloc bloc;
  final bool isToAccept;

  const TimeSlots({
    required this.bloc,
    this.isToAccept = false,
  });

  @override
  _TimeSlotsState createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {
  @override
  void initState() {
    if (!widget.isToAccept) {
      widget.bloc.getAvailableTimeSlots();
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.bloc.resetTimeSlotFields();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<ScheduleMeetingDetailBloc>.value(
      value: widget.bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
            listenWhen: (final prev, final next) =>
                prev.meetingRequestApi.message == null &&
                next.meetingRequestApi.message != null,
            listener: (final _, final state) {
              Navigator.of(context).pop();
            },
          ),
        ],
        child: FullScreenDrawer(
          child: Container(
            color: ColorUtils.lighten(
              Theme.of(context).primaryColor,
              0.95,
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: getValueForScreenType(
                  context: context,
                  mobile: 16,
                  tablet: 40,
                ),
                vertical: getValueForScreenType(
                  context: context,
                  mobile: 16,
                  tablet: 30,
                ),
              ),
              children: [
                Text(
                  translate(
                    context,
                    TranslationKeys
                        .Schedule_Meetings_User_Detail_Book_A_Meeting,
                  )!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  translate(
                    context,
                    TranslationKeys
                        .Schedule_Meetings_User_Detail_Select_Time_Slots,
                  )!,
                  style: TextStyle(
                    color: WCColors.black_09.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                _TimeSlotsListing(
                  isToAccept: widget.isToAccept,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeSlotsListing extends StatelessWidget {
  final bool isToAccept;

  const _TimeSlotsListing({
    required this.isToAccept,
  });

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingDetailBloc.of(context);
    return BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
      builder: (final _, final state) {
        final groupedTimeSlots = isToAccept
            ? state.userApi.data!.meeting!.groupedOtherTimeSlots
            : state.groupedTimeSlots;
        return groupedTimeSlots == null
            ? Center(
                child: ConnectionInformation(
                  error: state.timeSlotsApi.error,
                  onRetry: ScheduleMeetingDetailBloc.of(context)
                      .getAvailableTimeSlots,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < groupedTimeSlots.length; i++) ...[
                    const SizedBox(height: 21),
                    TimeZoneBlocBuilder(
                      builder: (final timeZone) => Text(
                        groupedTimeSlots[i].headerDate.format(
                              format: 'EEE MMM dd, yyyy',
                              timeZone: timeZone,
                            ),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    StaticGrid(
                      spacing: 8,
                      runSpacing: 8,
                      columns: getValueForScreenType(
                        context: context,
                        mobile: 2,
                        tablet: 3,
                      ),
                      children: groupedTimeSlots[i]
                          .timeSlots
                          .map(
                            (final ts) => _TimeSlotItem(
                              ts,
                              isToAccept: isToAccept,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 34),
                  Text(
                    translate(
                      context,
                      TranslationKeys
                          .Schedule_Meetings_User_Detail_Message_Optional,
                    )!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 17),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 5,
                    maxLines: null,
                    onChanged: bloc.updateMeetingRequestMessage,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(500),
                    ],
                  ),
                  const SizedBox(height: 12),
                  StaticGrid(
                    spacing: 6,
                    runSpacing: 6,
                    expand: getValueForScreenType(
                      context: context,
                      mobile: true,
                      tablet: false,
                    ),
                    columns: getValueForScreenType(
                      context: context,
                      mobile: 1,
                      tablet: 2,
                    ),
                    children: [
                      WCOutlinedButton(
                        title:
                            translate(context, TranslationKeys.General_Cancel),
                        backgroundColor: Colors.white,
                        borderColor: WCColors.grey_dd,
                        textColor: Theme.of(context).textTheme.bodyMedium?.color,
                        onTap: Navigator.of(context).pop,
                        type: getValueForScreenType(
                          context: context,
                          mobile: WCOutlinedButtonType.bigV,
                          tablet: WCOutlinedButtonType.bigA,
                        ),
                      ),
                      const _PositiveButton(),
                    ],
                  ),
                ],
              );
      },
    );
  }
}

class _TimeSlotItem extends StatelessWidget {
  final TimeSlotData timeSlot;
  final bool isToAccept;

  const _TimeSlotItem(
    this.timeSlot, {
    required this.isToAccept,
  });

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingDetailBloc.of(context);
    final state = bloc.state;
    final isSelected = state.selectedTimeSlotIds.contains(timeSlot.id);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.transparent : WCColors.grey_dd,
        ),
      ),
      child: WCInkWell(
        isDark: isSelected,
        onTap: () => bloc.toggleSelectedTimeSlotId(
          timeSlot.id,
          isSingleSelection: isToAccept,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Center(
          child: TimeZoneBlocBuilder(
            builder: (final timeZone) => Text(
              '${timeSlot.startDate.format(
                format: 'hh:mm a',
                timeZone: timeZone,
              )}-${timeSlot.endDate.format(
                format: 'hh:mm a',
                timeZone: timeZone,
              )}'
                  .toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : null,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PositiveButton extends StatelessWidget {
  const _PositiveButton();

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingDetailBloc.of(context);
    final profileId = ProfileBloc.of(context).state!.id;
    return BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
      builder: (final _, final state) {
        final meeting = state.userApi.data!.meeting;
        String? btnKey;
        MeetingStatus? status;
        if (meeting == null) {
          btnKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Send_Meeting_Request;
        } else {
          void fnSendMeetingRequest() {
            btnKey = TranslationKeys
                .Schedule_Meetings_User_Detail_Send_Meeting_Request;
          }

          meeting.callMeetingStatusEvent(
            profileId,
            MeetingStatusEvents(
              pendingMe: () {
                btnKey = TranslationKeys
                    .Schedule_Meetings_User_Detail_Update_Meeting_Request;
                status = MeetingStatus.pending;
              },
              pendingHim: () {
                btnKey = TranslationKeys.Schedule_Meetings_User_Detail_Accept;
                status = MeetingStatus.accepted;
              },
              rescheduledMe: () {
                btnKey = TranslationKeys.Schedule_Meetings_User_Detail_Accept;
                status = MeetingStatus.accepted;
              },
              rescheduledHim: () {
                btnKey = TranslationKeys
                    .Schedule_Meetings_User_Detail_Update_Rescheduled_Meeting_Request;
                status = MeetingStatus.rescheduled;
              },
              acceptedMe: () {
                btnKey = TranslationKeys
                    .Schedule_Meetings_User_Detail_Ask_To_Reschedule;
                status = MeetingStatus.postPending;
              },
              acceptedHim: () {
                btnKey = TranslationKeys
                    .Schedule_Meetings_User_Detail_Ask_To_Reschedule;
                status = MeetingStatus.postRescheduled;
              },
              postPendingMe: () {
                btnKey = TranslationKeys
                    .Schedule_Meetings_User_Detail_Update_Rescheduled_Meeting_Request;
                status = MeetingStatus.postPending;
              },
              postPendingHim: () {
                btnKey = TranslationKeys.Schedule_Meetings_User_Detail_Accept;
                status = MeetingStatus.accepted;
              },
              postRescheduledMe: () {
                btnKey = TranslationKeys.Schedule_Meetings_User_Detail_Accept;
                status = MeetingStatus.accepted;
              },
              postRescheduledHim: () {
                btnKey = TranslationKeys
                    .Schedule_Meetings_User_Detail_Update_Rescheduled_Meeting_Request;
                status = MeetingStatus.postRescheduled;
              },
              cancelledMe: fnSendMeetingRequest,
              cancelledHim: fnSendMeetingRequest,
              rejectedMe: fnSendMeetingRequest,
              rejectedHim: fnSendMeetingRequest,
              postCancelledMe: fnSendMeetingRequest,
              postCancelledHim: fnSendMeetingRequest,
              postRejectedMe: fnSendMeetingRequest,
              postRejectedHim: fnSendMeetingRequest,
            ),
          );
        }
        return WCOutlinedButton(
          title: translate(
            context,
            btnKey ?? 'N/A',
          ),
          backgroundColor: ColorUtils.lighten(
            Theme.of(context).primaryColor,
            0.9,
          ),
          borderColor: Theme.of(context).primaryColor,
          onTap: state.selectedTimeSlotIds.isEmpty
              ? null
              : () {
                  if (status == null) {
                    bloc.sendMeetingRequest();
                  } else if (status == MeetingStatus.accepted) {
                    bloc.acceptMeeting();
                  } else {
                    bloc.updateMeetingStatus(status!);
                  }
                },
          showLoader: state.meetingRequestApi.isApiInProgress,
          type: getValueForScreenType(
            context: context,
            mobile: WCOutlinedButtonType.bigV,
            tablet: WCOutlinedButtonType.bigA,
          ),
        );
      },
    );
  }
}
