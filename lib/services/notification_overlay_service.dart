import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/notification_overlay/bloc/notification_overlay_bloc.dart';
import '../pages/notification_overlay/bloc/notification_popup_item.dart';
import '../pages/notification_overlay/notification_overlay.dart';

class _NotificationOverlayService {
  OverlayEntry? _entry;
  NotificationOverlayBloc? _bloc;

  void initialize(final BuildContext context) {
    final overlayState = Overlay.maybeOf(context);
    final entry = OverlayEntry(
      builder: (final _) => BlocProvider(
        create: (final _) => _bloc = NotificationOverlayBloc(),
        child: const NotificationOverlay(),
      ),
    );
    overlayState?.insert(entry);
    _entry = entry;
  }

  void dispose() {
    _bloc = null;
    _entry?.remove();
    _entry = null;
  }

  void showNotification(final NotificationPopupItem item) {
    _bloc?.insert(item);
  }
}

final notificationOverlayService = _NotificationOverlayService();
