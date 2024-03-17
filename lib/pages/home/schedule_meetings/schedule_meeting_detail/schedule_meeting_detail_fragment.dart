import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/event_bloc.dart';
import '../../../../bloc/profile_bloc.dart';
import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../widgets/connection_information.dart';
import '../../../../widgets/dialogs.dart';
import 'bloc/schedule_meeting_detail_bloc.dart';
import 'bloc/schedule_meeting_detail_state.dart';
import 'user_detail.dart';

class ScheduleMeetingDetailFragment extends StatelessWidget {
  final int userId;
  final VoidCallback? onClose;

  const ScheduleMeetingDetailFragment(
    this.userId, {
    this.onClose,
  });

  @override
  Widget build(final BuildContext ctx) {
    return BlocProvider<ScheduleMeetingDetailBloc>(
      create: (final _) => ScheduleMeetingDetailBloc(
        userId: userId,
        profileBloc: ProfileBloc.of(ctx),
        eventBloc: EventBloc.of(ctx),
      ),
      child:
          BlocConsumer<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
        listenWhen: (final prev, final next) =>
            prev.meetingRequestApi.error == null &&
            next.meetingRequestApi.error != null,
        listener: (final context, final state) => WCDialog.showError(
          context,
          title: translate(
            context,
            TranslationKeys.Schedule_Meetings_User_Detail_Meeting_Error,
          ),
          subtitle: state.meetingRequestApi.error,
        ),
        builder: (final context, final state) => Container(
          color: Colors.white,
          child: state.userApi.data == null
              ? Center(
                  child: ConnectionInformation(
                    error: state.userApi.error,
                    onRetry:
                        ScheduleMeetingDetailBloc.of(context).getUserDetail,
                  ),
                )
              : UserDetail(
                  onClose: onClose,
                ),
        ),
      ),
    );
  }
}
