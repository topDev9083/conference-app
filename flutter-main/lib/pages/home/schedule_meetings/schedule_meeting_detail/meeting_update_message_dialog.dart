import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../models/enums/meeting_status.dart';
import '../../../../widgets/bloc_listener.dart';
import '../../../../widgets/close_icon.dart';
import '../../../../widgets/elevated_button.dart';
import '../../../../widgets/keyboard_remover.dart';
import '../../../../widgets/trn_text.dart';
import 'bloc/schedule_meeting_detail_bloc.dart';
import 'bloc/schedule_meeting_detail_state.dart';

class MeetingUpdateMessageDialog extends StatelessWidget {
  final String titleKey;
  final MeetingStatus meetingStatus;

  const MeetingUpdateMessageDialog._({
    required this.titleKey,
    required this.meetingStatus,
  });

  static Future<void> show(
    final BuildContext context, {
    required final String titleKey,
    required final MeetingStatus meetingStatus,
    required final ScheduleMeetingDetailBloc bloc,
  }) async {
    await showDialog(
      context: context,
      builder: (final _) => BlocProvider.value(
        value: bloc,
        child: Dialog(
          child: KeyboardRemover(
            child: MeetingUpdateMessageDialog._(
              titleKey: titleKey,
              meetingStatus: meetingStatus,
            ),
          ),
        ),
      ),
    );
    bloc.resetTimeSlotFields();
  }

  @override
  Widget build(final BuildContext context) {
    return PopBlocListener<ScheduleMeetingDetailBloc,
        ScheduleMeetingDetailState>(
      when: (final state) => state.meetingRequestApi.message,
      child: BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
        builder: (final _, final state) => SizedBox(
          width: DIALOG_WIDTH,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: CloseIcon(
                    onTap: Navigator.of(context).pop,
                  ),
                ),
                TrnText(
                  titleKey,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  enabled: !state.meetingRequestApi.isApiInProgress,
                  decoration: InputDecoration(
                    labelText: translate(
                      context,
                      TranslationKeys.Schedule_Meetings_User_Detail_Message,
                    ),
                    helperText:
                        translate(context, TranslationKeys.General_Optional),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: ScheduleMeetingDetailBloc.of(context)
                      .updateMeetingRequestMessage,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(500),
                  ],
                  onFieldSubmitted: (final _) => _onDone(context),
                ),
                const SizedBox(height: 22),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: WCElevatedButton(
                    translate(context, TranslationKeys.General_Done)!,
                    showLoader: state.meetingRequestApi.isApiInProgress,
                    onTap: () => _onDone(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDone(final BuildContext context) {
    ScheduleMeetingDetailBloc.of(context).updateMeetingStatus(meetingStatus);
  }
}
