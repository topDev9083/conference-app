import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'bloc/notification_overlay_bloc.dart';
import 'bloc/notification_overlay_state.dart';
import 'notification_popup.dart';

class NotificationOverlay extends StatelessWidget {
  const NotificationOverlay();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<NotificationOverlayBloc, NotificationOverlayState>(
      builder: (final _, final state) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getValueForScreenType(
              context: context,
              mobile: 16,
              tablet: 39,
            ),
            vertical: getValueForScreenType(
              context: context,
              mobile: 0,
              tablet: 29,
            ),
          ),
          child: Column(
            crossAxisAlignment: getValueForScreenType(
              context: context,
              mobile: CrossAxisAlignment.stretch,
              tablet: CrossAxisAlignment.end,
            ),
            children: [
              for (final item in state.notifications) ...[
                NotificationPopup(
                  id: item.id,
                  title: item.title,
                  subtitle: item.subtitle,
                  onTap: item.onTap == null ? null : () => item.onTap?.call(),
                  onClose: () =>
                      NotificationOverlayBloc.of(context).remove(item.id),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
