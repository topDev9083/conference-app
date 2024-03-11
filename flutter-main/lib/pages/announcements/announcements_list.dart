import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../models/data/announcement_data.dart';
import '../../utils/color_utils.dart';
import '../../widgets/image.dart';
import '../../widgets/ink_well.dart';
import '../announcement_detail/announcement_detail_dialog.dart';
import 'bloc/announcements_bloc.dart';
import 'bloc/announcements_state.dart';

class AnnouncementsList extends StatelessWidget {
  const AnnouncementsList();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AnnouncementsBloc, AnnouncementsState>(
      builder: (final context, final state) => ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        itemBuilder: (final _, final index) =>
            _AnnouncementItem(state.getAnnouncementsApi.data![index]),
        itemCount: state.getAnnouncementsApi.data!.length,
      ),
    );
  }
}

class _AnnouncementItem extends StatelessWidget {
  final AnnouncementData announcement;

  const _AnnouncementItem(this.announcement);

  @override
  Widget build(final BuildContext context) {
    return Container(
      color: announcement.isRead! ? null : WCColors.grey_f7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WCInkWell(
            onTap: () async {
              final bloc = AnnouncementsBloc.of(context);
              await AnnouncementDetailDialog.show(
                context,
                announcement: announcement,
              );
              bloc.markAnnouncementAsRead(announcement.id);
            },
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Container(
                  width: 37,
                  height: 37,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorUtils.lighten(
                      Theme.of(context).primaryColor,
                      0.8,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: WCImage(
                    image: 'ic_announcement.png',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        announcement.subject,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        announcement.message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: WCColors.grey_5d,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
