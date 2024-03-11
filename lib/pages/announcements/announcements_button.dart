import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../widgets/dot_heartbeat.dart';
import '../../widgets/image.dart';
import '../../widgets/sheet_button.dart';
import 'announcements_dropdown.dart';
import 'bloc/announcements_bloc.dart';
import 'bloc/announcements_state.dart';

class AnnouncementsButton extends StatelessWidget {
  const AnnouncementsButton();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AnnouncementsBloc, AnnouncementsState>(
      buildWhen: (final prev, final next) =>
          prev.unreadCount != next.unreadCount,
      builder: (final context, final state) => SheetButton(
        inkWellBorderRadius: 8,
        offset: 4,
        dropDownWidth: 312,
        fromEnd: true,
        button: _BellButton(
          showDot: state.unreadCount > 0,
        ),
        dropdown: (final _) => AnnouncementsDropdown(
          bloc: AnnouncementsBloc.of(context),
        ),
      ),
    );
  }
}

class _BellButton extends StatelessWidget {
  final bool showDot;

  const _BellButton({
    this.showDot = false,
  });

  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: WCColors.grey_f2,
          ),
          child: const Center(
            child: WCImage(
              image: 'ic_bell.png',
              width: 22,
            ),
          ),
        ),
        if (showDot) ...[
          const PositionedDirectional(
            top: 8,
            end: 8,
            child: DotHeartbeat(),
          ),
        ],
      ],
    );
  }
}
