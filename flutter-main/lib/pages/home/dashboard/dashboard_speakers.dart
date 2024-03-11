import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/user_data.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/ink_well.dart';
import '../router/home_route_bloc.dart';
import '../router/home_route_config.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_state.dart';
import 'dashboard_section_title.dart';

class DashboardSpeakers extends StatelessWidget {
  const DashboardSpeakers();

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<DashboardBloc, DashboardState>(
        builder: (final _, final state) {
          final speakers = state.api.data!.speakers;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 33),
              DashboardSectionTitle(
                translate(context, TranslationKeys.Dashboard_Speakers)!,
                onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
                  const HomeRouteConfig.speakers(),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < speakers.length; i++) ...[
                      _SpeakerItem(speakers[i]),
                      if (i != speakers.length - 1) ...[
                        const Divider(
                          indent: 8,
                          endIndent: 8,
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      );
}

class _SpeakerItem extends StatelessWidget {
  final UserData user;

  const _SpeakerItem(this.user);

  @override
  Widget build(final BuildContext context) {
    return WCInkWell(
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.05),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 18,
      ),
      onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
        const HomeRouteConfig.speakers(),
      ),
      child: Row(
        children: [
          UserAvatar(
            profilePicture: user.profilePicture,
            size: 56,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                if (user.jobAtOrganization != null) ...[
                  const SizedBox(height: 7),
                  Text(
                    user.jobAtOrganization!,
                    style: TextStyle(
                      fontSize: 12,
                      color: WCColors.black_09.withOpacity(0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
