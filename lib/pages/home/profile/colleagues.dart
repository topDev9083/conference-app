import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../widgets/colleague_item.dart';
import '../../../widgets/static_grid.dart';
import 'bloc/edit_profile_bloc.dart';
import 'bloc/edit_profile_state.dart';
import 'wrappers.dart';

class Colleagues extends StatelessWidget {
  const Colleagues();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (final context, final state) => PContainer(
        child: StaticGrid(
          columns: getValueForScreenType(
            context: context,
            mobile: 1,
            tablet: 2,
            desktop: 3,
          ),
          spacing: 10,
          runSpacing: 10,
          children: state.getColleaguesApi.data!
              .map((final colleague) => ColleagueItem(colleague))
              .toList(),
        ),
      ),
    );
  }
}
