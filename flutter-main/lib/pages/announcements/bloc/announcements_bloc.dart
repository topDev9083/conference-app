import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/response/api_response.dart';
import '../../../services/announcement_service.dart';
import '../../../services/socket_service.dart';
import '../../../widgets/cubit.dart';
import 'announcements_state.dart';

class AnnouncementsBloc extends WCCubit<AnnouncementsState> {
  StreamSubscription? onAnnouncementSub;

  AnnouncementsBloc() : super(AnnouncementsState()) {
    onAnnouncementSub = socketService.onAnnouncement
        .listen((final event) => getAnnouncements());
    getAnnouncements();
  }

  factory AnnouncementsBloc.of(final BuildContext context) =>
      BlocProvider.of<AnnouncementsBloc>(context);

  @override
  Future<void> close() async {
    await onAnnouncementSub?.cancel();
    return super.close();
  }

  Future<void> getAnnouncements() async {
    emit(
      state.rebuild(
        (final b) => b.getAnnouncementsApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final announcements = await announcementService.getAnnouncements();
      emit(
        state.rebuild((final b) => b.getAnnouncementsApi.data = announcements),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.getAnnouncementsApi
            ..error = metaData.message
            ..data = null,
        ),
      );
    }
    emit(
      state.rebuild((final b) => b.getAnnouncementsApi.isApiInProgress = false),
    );
  }

  void markAnnouncementAsRead(final int announcementId) {
    final index = state.getAnnouncementsApi.data
        ?.indexWhere((final an) => an.id == announcementId);
    if (index == null || index.isNegative) {
      return;
    }
    final announcement = state.getAnnouncementsApi.data![index]
        .rebuild((final bAnnouncement) => bAnnouncement.isRead = true);
    emit(
      state.rebuild(
        (final b) => b.getAnnouncementsApi.data = state
            .getAnnouncementsApi.data!
            .rebuild((final bData) => bData[index] = announcement),
      ),
    );
  }
}
