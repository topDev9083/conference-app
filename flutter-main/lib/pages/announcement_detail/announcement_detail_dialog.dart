import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../models/data/announcement_data.dart';
import '../../widgets/close_icon.dart';
import 'bloc/announcement_detail_bloc.dart';
import 'bloc/announcement_detail_state.dart';

class AnnouncementDetailDialog extends StatelessWidget {
  const AnnouncementDetailDialog._();

  static Future<void> show(
    final BuildContext context, {
    required final AnnouncementData announcement,
  }) {
    return showDialog(
      context: context,
      builder: (final _) => BlocProvider(
        create: (final _) => AnnouncementDetailBloc(
          announcement: announcement,
        ),
        child: const Dialog(
          child: AnnouncementDetailDialog._(),
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AnnouncementDetailBloc, AnnouncementDetailState>(
      builder: (final _, final state) => Container(
        constraints: const BoxConstraints(
          maxWidth: DIALOG_WIDTH,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 7,
                end: 7,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: CloseIcon(
                  onTap: Navigator.of(context).pop,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                state.announcement.subject,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                child: Text(
                  state.announcement.message,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
