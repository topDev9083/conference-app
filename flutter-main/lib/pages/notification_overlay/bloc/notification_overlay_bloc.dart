import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/audio_service.dart';
import '../../../widgets/cubit.dart';
import 'notification_overlay_state.dart';
import 'notification_popup_item.dart';

class NotificationOverlayBloc extends WCCubit<NotificationOverlayState>
    with WidgetsBindingObserver {
  var isAppPaused = false;

  NotificationOverlayBloc() : super(NotificationOverlayState()) {
    WidgetsBinding.instance.addObserver(this);
  }

  factory NotificationOverlayBloc.of(final BuildContext context) =>
      BlocProvider.of<NotificationOverlayBloc>(context);

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    isAppPaused = state == AppLifecycleState.paused;
    super.didChangeAppLifecycleState(state);
  }

  void insert(final NotificationPopupItem item) {
    if (isAppPaused) {
      return;
    }
    if (state.notifications.indexWhere((final i) => i.id == item.id) >= 0) {
      return;
    }
    audioService.playNotificationSound();
    emit(
      state.rebuild((final b) {
        if (state.notifications.length > 3) {
          b.notifications.removeAt(0);
        }
        b.notifications.add(item);
      }),
    );
  }

  void remove(final String itemId) {
    emit(
      state.rebuild(
        (final b) => b.notifications.removeWhere(
          (final i) => i.id == itemId,
        ),
      ),
    );
  }
}
