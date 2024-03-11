import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../widgets/colleague_item.dart';
import '../../../../widgets/connection_information.dart';
import '../../../../widgets/static_grid.dart';
import '../../../../widgets/trn_text.dart';
import 'bloc/schedule_meeting_detail_bloc.dart';
import 'bloc/schedule_meeting_detail_state.dart';

class Colleagues extends StatelessWidget {
  const Colleagues();

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingDetailBloc.of(context);
    return BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
      builder: (final _, final state) {
        final user = state.userApi.data;
        if (user!.organizationId == null) {
          return const SizedBox();
        } else if (state.colleaguesApi.data == null) {
          return Center(
            child: ConnectionInformation(
              error: state.colleaguesApi.error,
              onRetry: bloc.getColleagues,
            ),
          );
        } else if (state.colleaguesApi.data!.isEmpty) {
          return const SizedBox();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const SizedBox(height: 15),
              const TrnText(
                TranslationKeys.Schedule_Meetings_User_Detail_Colleagues,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 13),
              StaticGrid(
                columns: getValueForScreenType(
                  context: context,
                  mobile: 1,
                  tablet: 2,
                  desktop: 3,
                ),
                spacing: 10,
                runSpacing: 10,
                children: state.colleaguesApi.data!
                    .map((final colleague) => ColleagueItem(colleague))
                    .toList(),
              ),
            ],
          );
        }
      },
    );
  }
}
