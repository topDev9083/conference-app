import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../widgets/close_icon.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/trn_text.dart';
import 'bloc/update_user_note_bloc.dart';
import 'bloc/update_user_note_state.dart';

class UpdateUserNoteDialog extends StatelessWidget {
  const UpdateUserNoteDialog._();

  static Future<String?> show(
    final BuildContext context, {
    required final int userId,
    final String? note,
  }) {
    return showDialog(
      context: context,
      builder: (final _) => BlocProvider(
        create: (final _) => UpdateUserNoteBloc(
          userId: userId,
          note: note,
        ),
        child: const Dialog(
          child: UpdateUserNoteDialog._(),
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final bloc = UpdateUserNoteBloc.of(context);
    return BlocConsumer<UpdateUserNoteBloc, UpdateUserNoteState>(
      listenWhen: (final prev, final next) =>
          prev.updateNoteApi.message == null &&
          next.updateNoteApi.message != null,
      listener: (final context, final state) => Navigator.of(
        context,
        rootNavigator: true,
      ).pop(state.note),
      builder: (final _, final state) => SizedBox(
        width: DIALOG_WIDTH,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: CloseIcon(
                  onTap: () => Navigator.pop(context),
                ),
              ),
              const TrnText(
                TranslationKeys.Update_User_Note_Title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: state.note,
                minLines: 5,
                maxLines: 10,
                onChanged: bloc.updateNote,
                enabled: !state.updateNoteApi.isApiInProgress,
                decoration: InputDecoration(
                  errorText: state.updateNoteApi.error,
                  label: Text(
                    translate(
                      context,
                      TranslationKeys.Schedule_Meetings_User_Detail_Note,
                    )!,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: WCElevatedButton(
                  translate(context, TranslationKeys.General_Update)!,
                  showLoader: state.updateNoteApi.isApiInProgress,
                  onTap: () => _onUpdate(context),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _onUpdate(final BuildContext context) {
    UpdateUserNoteBloc.of(context).callUpdateNoteApi();
  }
}
