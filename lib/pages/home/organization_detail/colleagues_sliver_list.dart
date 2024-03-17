import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/colleague_item.dart';
import 'bloc/organization_detail_bloc.dart';
import 'bloc/organization_detail_state.dart';

class ColleaguesSliverList extends StatelessWidget {
  const ColleaguesSliverList();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<OrganizationDetailBloc, OrganizationDetailState>(
      builder: (final _, final state) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (final _, final index) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: ColleagueItem(
              state.getColleaguesApi.data![index],
              isFromDrawer: true,
            ),
          ),
          childCount: state.getColleaguesApi.data!.length,
        ),
      ),
    );
  }
}
