import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../utils/color_utils.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/ink_well.dart';
import '../router/home_route_bloc.dart';
import '../router/home_route_config.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_state.dart';

class DashboardAttendees extends StatelessWidget {
  const DashboardAttendees();

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<DashboardBloc, DashboardState>(
        builder: (final _, final state) {
          final users = state.api.data!.users;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 17),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              for (var i = 0; i < users.length; i++) ...[
                                UserAvatar(
                                  profilePicture: users[i].profilePicture,
                                  size: 29,
                                  borderRadius: 28,
                                ),
                                if (i != users.length - 1) ...[
                                  const SizedBox(width: 5),
                                ],
                              ],
                            ],
                          ),
                        ),
                        Text(
                          translate(
                            context,
                            TranslationKeys.Dashboard_Plus_100,
                          )!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      translate(
                        context,
                        TranslationKeys.Dashboard_Complete_Profile,
                      )!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorUtils.lighten(
                          Theme.of(context).primaryColor,
                          0.15,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: WCInkWell(
                        isDark: true,
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        borderRadius: BorderRadius.circular(5),
                        onTap: () =>
                            HomeRouteBloc.of(context).updateRouteConfig(
                          const HomeRouteConfig.scheduleMeetings(),
                        ),
                        child: Center(
                          child: Text(
                            translate(
                              context,
                              TranslationKeys.Dashboard_Start_Networking,
                            )!,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
}
