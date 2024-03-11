import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/response/api_response.dart';
import '../../../services/user_note_service.dart';
import '../../../widgets/cubit.dart';
import 'update_user_note_state.dart';

class UpdateUserNoteBloc extends WCCubit<UpdateUserNoteState> {
  UpdateUserNoteBloc({
    required final int userId,
    final String? note,
  }) : super(
          UpdateUserNoteState(
            (final b) => b
              ..userId = userId
              ..note = note ?? '',
          ),
        );

  factory UpdateUserNoteBloc.of(final BuildContext context) =>
      BlocProvider.of<UpdateUserNoteBloc>(context);

  void updateNote(final String note) {
    emit(state.rebuild((final b) => b.note = note));
  }

  Future<void> callUpdateNoteApi() async {
    emit(
      state.rebuild(
        (final b) => b.updateNoteApi
          ..isApiInProgress = true
          ..error = null
          ..message = null,
      ),
    );
    try {
      await userNoteService.updateUserNote(
        userId: state.userId,
        note: state.note,
      );
      emit(
        state.rebuild((final b) => b.updateNoteApi.message = 'success'),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.updateNoteApi.error = metaData.message),
      );
    }
    emit(state.rebuild((final b) => b.updateNoteApi.isApiInProgress = false));
  }
}
