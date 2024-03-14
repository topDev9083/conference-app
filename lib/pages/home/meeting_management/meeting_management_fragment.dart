import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'bloc/meeting_management_bloc.dart';
import 'meeting_management_list.dart';
import 'meeting_management_tabs.dart';

class MeetingManagementFragment extends StatelessWidget {
  const MeetingManagementFragment();

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => MeetingManagementBloc(),
      child: Container(
        color: getValueForScreenType(
          context: context,
          mobile: Colors.transparent,
          tablet: Colors.white,
        ),
        margin: getValueForScreenType(
          context: context,
          mobile: EdgeInsets.zero,
          tablet: const EdgeInsets.only(
            top: 20,
            left: 28,
            right: 28,
          ),
        ),
        child: const Column(
          children: [
            SizedBox(height: 17),
            MeetingManagementTabs(),
            Expanded(
              child: MeetingManagementList(),
            ),
          ],
        ),
      ),
    );
  }
}
