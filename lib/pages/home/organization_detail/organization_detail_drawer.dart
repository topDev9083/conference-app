import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home_drawer_bloc.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/organization_data.dart';
import '../../../utils/color_utils.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/full_screen_drawer.dart';
import 'bloc/organization_detail_bloc.dart';
import 'bloc/organization_detail_state.dart';
import 'colleagues_sliver_list.dart';
import 'organization_info.dart';

class OrganizationDetailDrawer extends StatelessWidget {
  const OrganizationDetailDrawer._();

  static void open(
    final BuildContext context, {
    required final OrganizationData organization,
    final String? boothNumber,
  }) {
    HomeDrawerBloc.of(context).updateEndDrawerWidget(
      BlocProvider(
        create: (final _) => OrganizationDetailBloc(
          organization: organization,
          boothNumber: boothNumber,
        ),
        child: const OrganizationDetailDrawer._(),
      ),
    );
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<OrganizationDetailBloc, OrganizationDetailState>(
      builder: (final _, final state) => FullScreenDrawer(
        width: 361,
        child: Container(
          color: ColorUtils.lighten(
            Theme.of(context).primaryColor,
            0.9,
          ),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: OrganizationInfo(),
              ),
              if (state.getColleaguesApi.data == null) ...[
                const SliverToBoxAdapter(
                  child: SizedBox(height: 30),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: ConnectionInformation(
                      error: state.getColleaguesApi.error,
                      onRetry: OrganizationDetailBloc.of(context).getColleagues,
                    ),
                  ),
                ),
              ] else if (state.getColleaguesApi.data!.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      translate(context, TranslationKeys.Profile_Colleagues)!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const ColleaguesSliverList(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
