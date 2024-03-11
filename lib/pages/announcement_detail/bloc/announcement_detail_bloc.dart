import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/data/announcement_data.dart';
import '../../../models/response/api_response.dart';
import '../../../services/announcement_service.dart';
import '../../../widgets/cubit.dart';
import 'announcement_detail_state.dart';

class AnnouncementDetailBloc extends WCCubit<AnnouncementDetailState> {
  AnnouncementDetailBloc({
    required final AnnouncementData announcement,
  }) : super(
          AnnouncementDetailState(
            (final b) => b.announcement.replace(announcement),
          ),
        ) {
    markAnnouncementAsRead();
  }

  factory AnnouncementDetailBloc.of(final BuildContext context) =>
      BlocProvider.of<AnnouncementDetailBloc>(context);

  Future<void> markAnnouncementAsRead() async {
    emit(
      state.rebuild(
        (final b) => b.markAnnouncementAsReadApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      await announcementService.markAnnouncementAsRead(state.announcement.id);
      emit(
        state.rebuild(
          (final b) => b.markAnnouncementAsReadApi.message = 'success',
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.markAnnouncementAsReadApi.error = metaData.message,
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.markAnnouncementAsReadApi.isApiInProgress = false,
      ),
    );
  }
}
