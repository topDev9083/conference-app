import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../widgets/ink_well.dart';
import '../../../../widgets/trn_text.dart';
import '../../../update_user_note/update_user_note_dialog.dart';
import 'bloc/schedule_meeting_detail_bloc.dart';
import 'bloc/schedule_meeting_detail_state.dart';

class Notes extends StatelessWidget {
  const Notes();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
      builder: (final _, final state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(),
          const SizedBox(height: 15),
          Row(
            children: [
              const TrnText(
                TranslationKeys.Schedule_Meetings_User_Detail_Note,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              WCInkWell(
                onTap: () => _onEditNote(context),
                isCircle: true,
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            state.userApi.data!.note ?? '--',
          ),
        ],
      ),
    );
  }

  Future<void> _onEditNote(final BuildContext context) async {
    final bloc = ScheduleMeetingDetailBloc.of(context);
    final state = bloc.state;
    final newNote = await UpdateUserNoteDialog.show(
      context,
      userId: state.userId,
      note: state.userApi.data?.note,
    );
    if (newNote == null) {
      return;
    }
    bloc.updateUserNote(newNote);
  }
}
