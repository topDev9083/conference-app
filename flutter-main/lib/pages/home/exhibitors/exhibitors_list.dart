import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../models/data/exhibitor_data.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/organization_item.dart';
import 'bloc/exhibitors_bloc.dart';
import 'bloc/exhibitors_state.dart';

class ExhibitorsList extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ExhibitorsBloc, ExhibitorsState>(
      builder: (final _, final state) => state.exhibitorsApi.data == null
          ? Center(
              child: ConnectionInformation(
                error: state.exhibitorsApi.error,
                onRetry: ExhibitorsBloc.of(context).getExhibitors,
              ),
            )
          : MasonryGridView.count(
              padding: EdgeInsets.symmetric(
                vertical: getValueForScreenType(
                  context: context,
                  mobile: 16,
                  tablet: 25,
                ),
              ),
              crossAxisCount: getValueForScreenType(
                context: context,
                mobile: 1,
                tablet: 2,
              ),
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              itemBuilder: (final _, final index) =>
                  _ExhibitorItem(state.exhibitorsApi.data![index]),
              itemCount: state.exhibitorsApi.data!.length,
            ),
    );
  }
}

class _ExhibitorItem extends StatelessWidget {
  final ExhibitorData exhibitor;

  const _ExhibitorItem(this.exhibitor);

  @override
  Widget build(final BuildContext context) {
    final organization = exhibitor.organization!;
    return OrganizationItem(
      organization,
      boothNumber: exhibitor.boothNumber,
    );
  }
}
