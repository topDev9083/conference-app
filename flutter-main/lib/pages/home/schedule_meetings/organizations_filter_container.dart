import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/checkbox_tile.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/list_paginator.dart';
import '../../../widgets/search_text_form_field.dart';
import 'bloc/schedule_meetings_bloc.dart';
import 'bloc/schedule_meetings_state.dart';

class OrganizationsFilterContainer extends StatelessWidget {
  final ScheduleMeetingsBloc bloc;

  const OrganizationsFilterContainer(this.bloc);

  @override
  Widget build(final BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ScheduleMeetingsBloc, ScheduleMeetingsState>(
        builder: (final _, final state) => Column(
          children: [
            const SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SearchTextFormField(
                initialValue: state.organizationsSearch,
                onChanged: bloc.updateOrganizationsSearch,
              ),
            ),
            Expanded(
              child: state.organizationsApi.data == null
                  ? Center(
                      child: ConnectionInformation(
                        error: state.organizationsApi.error,
                        onRetry: bloc.searchOrganizations,
                      ),
                    )
                  : Scrollbar(
                      child: ListView.builder(
                        itemBuilder: (final _, final index) {
                          final list = state.organizationsApi.data!;
                          if (index >= list.length) {
                            return ListPaginator(
                              error: state.organizationsApi.error,
                              onLoad: () =>
                                  bloc.searchOrganizations(list.length),
                            );
                          }
                          final org = list[index];
                          return WCCheckboxTile(
                            title: org.name,
                            value:
                                state.selectedOrganizationIds.contains(org.id),
                            onChanged: (final isChecked) => isChecked
                                ? bloc.addOrganizationId(org.id)
                                : bloc.removeOrganizationId(org.id),
                          );
                        },
                        itemCount: state.organizationsApi.data!.length +
                            (state.organizationsApi.isApiPaginationEnabled
                                ? 1
                                : 0),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
